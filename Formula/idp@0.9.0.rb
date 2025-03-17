# Generated through hack/update-taps.sh. Don't edit manually.
# Next line is used to identify version of the file.
# idpbuilder_version:0.9.0
#
require "fileutils"

class IdpAT090 < Formula
  homepage "https://github.com/cnoe-io/idpbuilder"

  v = "v0.9.0"
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
    if OS.mac? && Hardware::CPU.intel?
      FileUtils.mv("idpbuilder-darwin-amd64", "idpbuilder")
    elsif OS.mac? && Hardware::CPU.arm?
      FileUtils.mv("idpbuilder-darwin-arm64", "idpbuilder")
    elsif OS.linux? && Hardware::CPU.arm?
      FileUtils.mv("idpbuilder-linux-arm64", "idpbuilder")
    else
      FileUtils.mv("idpbuilder-linux-amd64", "idpbuilder")
    end
    bin.install "idpbuilder"
  end

  test do
    system "#{bin}/idpbuilder --version"
  end
end
