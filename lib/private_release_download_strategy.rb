# frozen_string_literal: true

# Download strategy for GitHub release assets in private repositories.
#
# Homebrew's stock GitHub release strategy does not authenticate, so private
# assets 404. This strategy resolves the release by tag through the GitHub
# API, finds the asset, and downloads it from the API asset endpoint using
# the user's HOMEBREW_GITHUB_API_TOKEN.
#
# Requirement: HOMEBREW_GITHUB_API_TOKEN with read (contents) access to the
# repository hosting the release.
class PrivateReleaseDownloadStrategy < AbstractDownloadStrategy
  def fetch(timeout: nil)
    url = resource.url
    m = %r{\Ahttps://github\.com/(?<owner>[\w.-]+)/(?<repo>[\w.-]+)/releases/download/(?<tag>[^/]+)/(?<asset>[^/?#]+)\z}.match(url)
    raise "URL is not a GitHub release download URL: #{url}" unless m

    token = ENV["HOMEBREW_GITHUB_API_TOKEN"].to_s
    if token.empty?
      raise <<~EOS
        HOMEBREW_GITHUB_API_TOKEN is not set. This formula downloads release
        assets from the private repository #{m[:owner]}/#{m[:repo]}; the
        token must have read access to it.
      EOS
    end

    auth = ["Authorization: token #{token}",
            "Accept: application/vnd.github+json",
            "X-GitHub-Api-Version: 2022-11-28"]

    release_url = "https://api.github.com/repos/#{m[:owner]}/#{m[:repo]}/releases/tags/#{m[:tag]}"
    json, _err, _status = curl_output "--silent", "--show-error", "--fail",
                                      "--header", auth[0], "--header", auth[1], "--header", auth[2],
                                      release_url
    release = Utils::JSON.parse(json)
    asset = release["assets"].find { |a| a["name"] == m[:asset] }
    raise "Asset #{m[:asset]} not found in release #{m[:tag]}" unless asset

    curl_download asset["url"],
                  to: cached_location,
                  timeout: timeout,
                  headers: ["Authorization: token #{token}",
                            "Accept: application/octet-stream",
                            "X-GitHub-Api-Version: 2022-11-28"]
  end

  def cached_location
    # Content-disposition carries the real filename; keep a stable cache
    # path derived from the URL basename.
    basename = resource.url.rpartition("/").last
    @cached_location ||= HOMEBREW_CACHE/basename
  end

  def clear_cache
    cached_location.unlink if cached_location.exist?
  end
end
