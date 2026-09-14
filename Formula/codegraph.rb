class Codegraph < Formula
  desc "MCP server that indexes Go codebases into a queryable code graph"
  homepage "https://github.com/langazov/go-codegraph"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.2/codegraph-v0.1.2-darwin-amd64.tar.gz"
      sha256 "745b463ed4eaf9fed0fe8c1c12151c95318268ca9d4f4063851014ca525558cd"

      def install
        bin.install "codegraph-v0.1.2-darwin-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.2/codegraph-v0.1.2-darwin-arm64.tar.gz"
      sha256 "eed2c47309a0c110519c5a786a13f6e9398ff283eff4cef3cdb4f9f8a4c1fcba"

      def install
        bin.install "codegraph-v0.1.2-darwin-arm64" => "codegraph"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.2/codegraph-v0.1.2-linux-amd64.tar.gz"
      sha256 "788a87679b4a8a340096fc33500abf89cc585474f588c6af948e48d92370fec5"

      def install
        bin.install "codegraph-v0.1.2-linux-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://s3.gocoder.org/releases/codegraph/v0.1.2/codegraph-v0.1.2-linux-arm64.tar.gz"
      sha256 "a823a6c846c1542e59a36ee2487b24235939a9bd1397029c6f304a666dd43c47"

      def install
        bin.install "codegraph-v0.1.2-linux-arm64" => "codegraph"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/codegraph version")
  end
end
