class Codegraph < Formula
  desc "MCP server that indexes Go codebases into a queryable code graph"
  homepage "https://github.com/langazov/go-codegraph"
  version "0.0.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-darwin-amd64.tar.gz"
      sha256 "13e67264cae798af1561f9474fbec8a0b0e144fe8c1876eabe81f973430f7de6"

      def install
        bin.install "codegraph-v0.0.5-darwin-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-darwin-arm64.tar.gz"
      sha256 "74e5d48f4104c815c8f6d155ae48d7d13850f33f4f2dbc93c978b97b4e713e11"

      def install
        bin.install "codegraph-v0.0.5-darwin-arm64" => "codegraph"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-linux-amd64.tar.gz"
      sha256 "ca729f64eafa95cb81eac711ea0cb4e9559cdb68a876733623860d37a9e2c2a5"

      def install
        bin.install "codegraph-v0.0.5-linux-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-linux-arm64.tar.gz"
      sha256 "6b7d1721fd143e688b1ce39719ddc3035be52b866cb799d036801fcdef329f36"

      def install
        bin.install "codegraph-v0.0.5-linux-arm64" => "codegraph"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/codegraph version")
  end
end
