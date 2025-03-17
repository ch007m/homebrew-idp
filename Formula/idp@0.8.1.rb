# Generated through hack/update-taps.sh. Don't edit manually.
# idpbuilder_version:0.8.1
require "fileutils"

class IdpAT081 < Formula
  homepage "https://github.com/cnoe-io/idpbuilder"
  v = "v0.8.1"
  version v

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-amd64.tar.gz"
    sha256 "faab9a214977f7856434e1fc0cbf2b852eb189627709cfb7e6a11e9d85d10588"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-arm64.tar.gz"
    sha256 "79192e9656d8d25e813d16179464095edcde13440490507a434ec97a318f1bae"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-arm64.tar.gz"
    sha256 "ceaa2a3a62168cb67db4179e6fbf1c5b72d86fb0351ded85bf7032c4477ac5cf"
  else
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-amd64.tar.gz"
    sha256 "782532a56c5741c33ad868ef4b05bdb0650133ffb5a23001d8e07e5764257319"
  end

  def install
    FileUtils.mv("idpbuilder", "idp")
    bin.install "idp"
  end

  test do
    system "#{bin}/idp --version"
  end
end
