cask "b-anime" do
  version "0.4.7"
  sha256 "3c0a877b40e02393b5d8e08b0472c1c1a8fa709a68f0338ae5197ff77f0f9bff"

  url "https://github.com/ahmedanjum30/B-Anime/releases/download/v#{version}/B-Anime-#{version}-macos.zip"
  name "B-Anime"
  desc "Anime and manga library that tracks what you watch on AniList"
  homepage "https://ahmedanjum30.github.io/B-Anime/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # B-Anime updates itself; brew upgrade leaves it alone unless asked to (--greedy).
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "B-Anime.app"

  # Signed ad hoc, not notarized: without this Gatekeeper won't open it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/B-Anime.app"]
  end

  uninstall quit: "app.banime.desktop"

  zap trash: [
    "~/Library/Application Support/B-Anime",
    "~/Library/Caches/app.banime.desktop",
    "~/Library/WebKit/app.banime.desktop",
  ]
end
