class Codegraph < Formula
  desc "MCP server that indexes Go codebases into a queryable code graph"
  homepage "https://github.com/langazov/go-codegraph"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.3/codegraph-v0.1.3-darwin-amd64.tar.gz"
      sha256 "35f975758ab6c3beb97a87bcfd948a8e0915c3c0c88e38b9426892bc7a51de38"

      def install
        bin.install "codegraph-v0.1.3-darwin-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.3/codegraph-v0.1.3-darwin-arm64.tar.gz"
      sha256 "02c02c52a06aa89b45785706d86dde60cfe4f71bb9c0b08ccbee3f15c22b4aa4"

      def install
        bin.install "codegraph-v0.1.3-darwin-arm64" => "codegraph"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.3/codegraph-v0.1.3-linux-amd64.tar.gz"
      sha256 "cd9b4163e7db7f5d179f1750d6228b5c47bfb507691f72c5fa078d7ab14fe81f"

      def install
        bin.install "codegraph-v0.1.3-linux-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.3/codegraph-v0.1.3-linux-arm64.tar.gz"
      sha256 "3d315db0fb1df4c28a589cc71c53c832ad74f7edf4d54077a3a27dbdf80bb568"

      def install
        bin.install "codegraph-v0.1.3-linux-arm64" => "codegraph"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/codegraph version")
  end
end
