# frozen_string_literal: true

# Download strategy for GitHub release assets in private repositories.
#
# Homebrew's stock GitHub release strategy does not authenticate, so private
# assets 404. This strategy resolves the release by tag through the GitHub
# API and downloads the asset from the API asset endpoint using the user's
# HOMEBREW_GITHUB_API_TOKEN.
#
# Requirement: HOMEBREW_GITHUB_API_TOKEN with read (contents) access to the
# repository hosting the release.
class PrivateReleaseDownloadStrategy < CurlDownloadStrategy
  def fetch(timeout: nil)
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

    require "open3"
    require "json"
    auth = ["Authorization: token #{token}",
            "Accept: application/vnd.github+json",
            "X-GitHub-Api-Version: 2022-11-28"]
    release_url = "https://api.github.com/repos/#{m[:owner]}/#{m[:repo]}/releases/tags/#{m[:tag]}"
    json, _err, _status = Open3.capture3("curl", "--silent", "--show-error", "--fail",
                                         "--header", auth[0], "--header", auth[1], "--header", auth[2],
                                         release_url)
    release = JSON.parse(json)
    asset = release["assets"].find { |a| a["name"] == m[:asset] }
    raise "Asset #{m[:asset]} not found in release #{m[:tag]}" unless asset

    ohai "Downloading #{m[:asset]} from private release #{m[:tag]}"
    FileUtils.rm_f(temporary_path)
    curl_download asset["url"],
                  "--header", "Authorization: token #{token}",
                  "--header", "Accept: application/octet-stream",
                  "--header", "X-GitHub-Api-Version: 2022-11-28",
                  to: temporary_path
    cached_location.dirname.mkpath
    FileUtils.mv(temporary_path, cached_location)
  end
end
