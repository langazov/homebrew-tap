class Codegraph < Formula
  desc "MCP server that indexes Go codebases into a queryable code graph"
  homepage "https://github.com/langazov/go-codegraph"
  version "0.0.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-darwin-amd64.tar.gz"
      sha256 "d0b999924fb270cc8c6254b7720746b53935788c5cbe7214a0b3065c02a66af2"

      def install
        bin.install "codegraph-v0.0.2-darwin-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-darwin-arm64.tar.gz"
      sha256 "8da0639d7a38b786f4e683e3f49665b6e4e4d6c6e987182b63abd9bf2c28596a"

      def install
        bin.install "codegraph-v0.0.2-darwin-arm64" => "codegraph"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-linux-amd64.tar.gz"
      sha256 "eb389fb340cba88f0d7dd31706b794f71a4c36ec4621d4f0bae83f2c19f01976"

      def install
        bin.install "codegraph-v0.0.2-linux-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-linux-arm64.tar.gz"
      sha256 "370c022096f55afb2c1931b73586a9d1114cc35c282c74658e62d7ce14571b10"

      def install
        bin.install "codegraph-v0.0.2-linux-arm64" => "codegraph"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/codegraph version")
  end
end
