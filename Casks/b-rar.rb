cask "b-rar" do
  version "1.5.4"
  sha256 "3de71fee022ad84629eee5c9291642f2079e1ca9d04d469366c3073fe39b23c7"

  url "https://github.com/ahmedanjum30/B-Rar/releases/download/v#{version}/B-Rar-#{version}-macos.zip"
  name "B-Rar"
  desc "Fast archive extractor for ZIP, RAR, 7z and tar"
  homepage "https://ahmedanjum30.github.io/B-Rar/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "B-Rar.app"
  # The command line, as on Linux: brar x archive.rar
  binary "#{appdir}/B-Rar.app/Contents/MacOS/B-Rar", target: "brar"

  postflight do
    # Signed ad hoc, not notarized: without this Gatekeeper won't open it.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/B-Rar.app"]
    # Shows B-Rar's Quick Actions in Finder's right-click menu right away.
    system_command "/System/Library/CoreServices/pbs", args: ["-update"]
  end

  uninstall quit: "com.ahmadanjum.brar"

  zap trash: [
    "~/Library/Saved Application State/com.ahmadanjum.brar.savedState",
  ]
end
