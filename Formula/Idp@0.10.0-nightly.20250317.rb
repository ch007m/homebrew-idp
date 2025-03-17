#
# Generated through hack/update-taps.sh. Don't edit manually.
# Next line is used to identify version of the file.
# idpbuilder_version:0.10.0-nightly.20250317
#
class IdpAT0100Nightly20250317 < Formula
  desc ""
  homepage "https://cnoe.io"
  version "0.10.0-nightly.20250317"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/cnoe-io/idpbuilder/releases/download/v0.10.0-nightly.20250317/idpbuilder-darwin-amd64.tar.gz"
      sha256 "0176ef54598e17e027d6db8d4a8ee02740c80b9167816093d8bce16f46c3dd7e"

      def install
        bin.install "idpbuilder"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/cnoe-io/idpbuilder/releases/download/v0.10.0-nightly.20250317/idpbuilder-darwin-arm64.tar.gz"
      sha256 "ee85fa6fba2fc491fd48e38b033a7b640f48ea7ca771447a543dfdca7aac626b"

      def install
        bin.install "idpbuilder"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/cnoe-io/idpbuilder/releases/download/v0.10.0-nightly.20250317/idpbuilder-linux-amd64.tar.gz"
        sha256 "5cc563da57f210b50d1b511d8a84761b65cd4c112bd3bd3aac18679939f22aa0"

        def install
          bin.install "idpbuilder"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/cnoe-io/idpbuilder/releases/download/v0.10.0-nightly.20250317/idpbuilder-linux-arm64.tar.gz"
        sha256 "5c6f351bb9d61c8d0e1d1f270488d4d2b5bbe45aa3be0eb0f5782b1f44cc52fc"

        def install
          bin.install "idpbuilder"
        end
      end
    end
  end

  test do
    system "#{bin}/idpbuilder --version"
  end
end
