require_relative "../lib/private_release_download_strategy"

class Codegraph < Formula
  desc "MCP server that indexes Go codebases into a queryable code graph"
  homepage "https://github.com/langazov/go-codegraph"
  version "0.0.2"

  # NOTE: the upstream repository is private. Release assets are fetched
  # through the GitHub API with your token:
  #
  #   export HOMEBREW_GITHUB_API_TOKEN=<token with read access to langazov/go-codegraph>
  #   brew install langazov/tap/codegraph

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-darwin-amd64.tar.gz",
          using: PrivateReleaseDownloadStrategy
      sha256 "765ec4b3972afcd7ac6edd2229d6e887f69034d46c3bcc736d938a9d2d64d4c0"

      def install
        bin.install "codegraph-v0.0.2-darwin-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-darwin-arm64.tar.gz",
          using: PrivateReleaseDownloadStrategy
      sha256 "6f159000b434ac60a8c97846a05f2ab952bdc9ff532e1494dd3574ea84f8554e"

      def install
        bin.install "codegraph-v0.0.2-darwin-arm64" => "codegraph"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-linux-amd64.tar.gz",
          using: PrivateReleaseDownloadStrategy
      sha256 "0b225c805e615847e06909422b1592c72670103e52088a2ba0a6c51096033104"

      def install
        bin.install "codegraph-v0.0.2-linux-amd64" => "codegraph"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/langazov/go-codegraph/releases/download/v0.0.2/codegraph-v0.0.2-linux-arm64.tar.gz",
          using: PrivateReleaseDownloadStrategy
      sha256 "003483210849f84a1a579824d355a8e42dccc1e339eba4d650f8433f27a17315"

      def install
        bin.install "codegraph-v0.0.2-linux-arm64" => "codegraph"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/codegraph version")
  end
end
