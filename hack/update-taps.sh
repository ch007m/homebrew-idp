#! /usr/bin/env bash

# Copyright 2024 The cnoe-io idpbuilder Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

# Retrieve version from given Idpbuilder repository tags
function get_latest_release_version() {
    local org_name="$1"
    local repo_name="$2"
    local version
    version="$(git ls-remote --tags --ref https://github.com/"${org_name}"/"${repo_name}".git \
      | cut -f2 \
      | cut -d 'v' -f2 \
      | sed 's#refs/tags/##' \
      | sort -Vr \
      | head -n 1)"
    echo "${version}"
}

# Return the major version of a release.
# For example, "v0.2.1" returns "0"
# Parameters: $1 - release version label.
function major_version() {
  local release="${1//v/}"
  local tokens=(${release//\./ })
  echo "${tokens[0]}"
}

# Return the minor version of a release.
# For example, "v0.2.1" returns "2"
# Parameters: $1 - release version label.
function minor_version() {
  local tokens=(${1//\./ })
  echo "${tokens[1]}"
}

# Return the release build number of a release.
# For example, "v0.2.1" returns "1".
# Parameters: $1 - release version label.
function patch_version() {
  local tokens=(${1//\./ })
  echo "${tokens[2]}"
}

# Generate file based on the inlined HEREDOC template.
function generate_tap_file() {
  local out=$1
  local version=$2
  local old_formula=${3:-""}
  local darwin_amd64_checksum darwin_arm64_checksum linux_amd64_checksum linux_arm64_checksum

  # Fetch checksum file from release and parse values
  checksums=$(mktemp)
  curl -fsSL "https://github.com/cnoe-io/idpbuilder/releases/download/v${2}/checksums.txt" > "$checksums"
  darwin_amd64_checksum=$(awk '$2=="idpbuilder-darwin-amd64"{print $1}' "$checksums")
  darwin_arm64_checksum=$(awk '$2=="idpbuilder-darwin-arm64"{print $1}' "$checksums")
  linux_amd64_checksum=$(awk '$2=="idpbuilder-linux-amd64"{print $1}' "$checksums")
  linux_arm64_checksum=$(awk '$2=="idpbuilder-linux-arm64"{print $1}' "$checksums")
  # Cleanup temp file
  rm "${checksums}"

cat <<EOF > "$out"
# Generated through hack/update-taps.sh. Don't edit manually.
# Next line is used to identify version of the file.
# idpbuilder_version:${version}
#
require "fileutils"

class ${old_formula} < Formula
  homepage "https://github.com/cnoe-io/idpbuilder"

  v = "v${version}"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-amd64"
    sha256 "${darwin_amd64_checksum}"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-arm64"
    sha256 "${darwin_arm64_checksum}"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-arm64"
    sha256 "${linux_arm64_checksum}"
  else
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-amd64"
    sha256 "${linux_amd64_checksum}"
  end

  def install
    FileUtils.mv("idpbuilder", "idp")
    bin.install "idp"
  end

  test do
    system "#{bin}/idp --version"
  end
end
EOF
}

function generateNightlyFormulaClassname() {
  echo "${IDP_CLI_VERSION}" | grep "\-nightly" > /dev/null &&  echo "${IDP_CLI_VERSION}" | sed -e 's/[\.\-]//g' | sed -e 's/n/N/' | xargs -I {} echo "IdpAT{}" || echo "Idp"
}

function generateFormulaClassname() {
    local version=$1
    echo "${version}" | sed -e 's/[\.\-]//g' | xargs -I {} echo "IdpAT{}"
}
# The script is meant to be executed though GH action to generate content update and review in the PR.

[[ ! -v REPO_ROOT_DIR ]] && REPO_ROOT_DIR="$(git rev-parse --show-toplevel)"
readonly REPO_ROOT_DIR

pushd $REPO_ROOT_DIR/Formula

# Get sem version from idpbuilder.rb file, in format x.y.z
current_homebrew_version=$(cat "idp.rb" | grep "idpbuilder_version:" | cut -d ':' -f2)

# Get latest released version from cnoe-io/idpbuilder git repository
IDP_CLI_VERSION=$(get_latest_release_version "cnoe-io" "idpbuilder")
#IDP_CLI_VERSION="0.9.0"

# If this a nightly release, simply generate a new Formula
if [[ ${IDP_CLI_VERSION} == *"nightly"* ]]; then
  echo "This is a nightly build"
  nightly_formula_filename="idp@${IDP_CLI_VERSION}.rb"
  generate_tap_file "${nightly_formula_filename}" "${IDP_CLI_VERSION}" "$(generateNightlyFormulaClassname)"
  exit 0
fi


echo "Generate definition for older release first"
old_release_filename="idp@${current_homebrew_version}.rb"
generate_tap_file "${old_release_filename}" "${current_homebrew_version}" "$(generateFormulaClassname ${current_homebrew_version})"

echo "--------------------------------------"
echo "Generate the new release idp.rb file"
generate_tap_file "idp.rb" "${IDP_CLI_VERSION}" "$(generateFormulaClassname ${IDP_CLI_VERSION})"
