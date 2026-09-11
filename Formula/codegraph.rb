class Codegraph < Formula
  desc "MCP server that indexes Go codebases into a queryable code graph"
  homepage "https://github.com/langazov/go-codegraph"
  version "0.0.5"

  on_macos do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-darwin-amd64.tar.gz"
      sha256 "bc172beac8c1c07b427ff49cfabd45bc29f13fb89fec27c3b2f24a3bab04de9d"

      def install
        bin.install "codegraph-v0.0.5-darwin-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-darwin-arm64.tar.gz"
      sha256 "3028b186e4e4d6a1126ef12d97a83687fa37222c9b081cecade123d7b1e01df9"

      def install
        bin.install "codegraph-v0.0.5-darwin-arm64" => "codegraph"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.0.5/codegraph-v0.0.5-linux-amd64.tar.gz"
      sha256 "4cd437aa74d619d207bdd0c020277cb749b85336c9bbee991be2d61107224845"

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
