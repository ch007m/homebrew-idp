#
# Generated through hack/update-taps.sh. Don't edit manually.
# Next line is used to identify version of the file.
# idpbuilder_version:0.10.0-nightly.20250317
#
class IdpAT0100Nightly20250317 < Formula
  desc ""
  homepage "https://cnoe.io"
  v = "v0.10.0-nightly.20250317"
  version v
  
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-amd64.tar.gz"
    sha256 ""
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-darwin-arm64.tar.gz"
    sha256 ""
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-arm64.tar.gz"
    sha256 ""
  else
    url "https://github.com/cnoe-io/idpbuilder/releases/download/#{v}/idpbuilder-linux-amd64.tar.gz"
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
