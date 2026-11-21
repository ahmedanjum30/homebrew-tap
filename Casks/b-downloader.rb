cask "b-downloader" do
  version "1.5.1"
  sha256 "76b22aea96eba7d3754032862987607343f1e4905c44751c3d386610ca80bd2f"

  url "https://github.com/ahmedanjum30/B-Downloader/releases/download/v#{version}/B-Downloader-#{version}-macos.zip"
  name "B-Downloader"
  desc "Download manager that fetches files over parallel connections"
  homepage "https://github.com/ahmedanjum30/B-Downloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "B-Downloader.app"

  # Signed ad hoc, not notarized: without this Gatekeeper won't open it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/B-Downloader.app"]
  end

  uninstall quit: "com.ahmadanjum.bdownloader"

  zap trash: [
    "~/B-Downloader",
    "~/Library/Application Support/B-Downloader",
    "~/Library/Containers/com.ahmadanjum.bdownloader.safari",
    "~/Library/Application Support/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.bdownloader.host.json",
    "~/Library/Application Support/Chromium/NativeMessagingHosts/com.bdownloader.host.json",
    "~/Library/Application Support/com.operasoftware.Opera/NativeMessagingHosts/com.bdownloader.host.json",
    "~/Library/Application Support/Google/Chrome/NativeMessagingHosts/com.bdownloader.host.json",
    "~/Library/Application Support/Microsoft Edge/NativeMessagingHosts/com.bdownloader.host.json",
    "~/Library/Application Support/Mozilla/NativeMessagingHosts/com.bdownloader.host.json",
    "~/Library/Application Support/Vivaldi/NativeMessagingHosts/com.bdownloader.host.json",
  ]
end
