# Generated through hack/update-taps.sh. Don't edit manually.
# Next line is used to identify version of the file.
# idpbuilder_version:0.8.1
#
require "fileutils"

class IdpAT081 < Formula
  homepage "https://github.com/cnoe-io/idpbuilder"

  v = "v0.8.1"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-amd64"
    sha256 ""
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-arm64"
    sha256 ""
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-arm64"
    sha256 ""
  else
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-amd64"
    sha256 ""
  end

  def install
    FileUtils.mv("idpbuilder", "idp")
    bin.install "idp"
  end

  test do
    system "#{bin}/idp --version"
  end
end
