cask "game-porting-toolkit" do
  version "3.0-beta2"
  sha256 "a72c8ac93d22e74b4d9388de28a72eb484641b163b4fa3bf5bcd8d602f1bffef"

  url "https://github.com/Gcenx/game-porting-toolkit/releases/download/Game-Porting-Toolkit-#{version}/game-porting-toolkit-#{version}.tar.xz",
      verified: "github.com/Gcenx/game-porting-toolkit/"
  name "Game Porting Toolkit"
  desc "Use to eliminate months of up-front work and evaluate how well your game runs"
  homepage "https://developer.apple.com/games"

  livecheck do
    url :url
    strategy :github_releases
  end

  conflicts_with cask: %w[
    wine-crossover
    wine@devel
    wine-stable
    wine@staging
  ]
  depends_on macos: ">= :sonoma"

  app "Game Porting Toolkit.app"
  binary "#{appdir}/Game Porting Toolkit.app/Contents/Resources/wine/bin/wine64"
  binary "#{appdir}/Game Porting Toolkit.app/Contents/Resources/wine/bin/wine64-preloader"
  binary "#{appdir}/Game Porting Toolkit.app/Contents/Resources/wine/bin/wineserver"

  postflight do
    system "/usr/bin/xattr", "-drs", "com.apple.quarantine", "#{appdir}/Game Porting Toolkit.app"
    system "/usr/bin/codesign", "--force", "--deep", "-s", "-", "#{appdir}/Game Porting Toolkit.app"
  end

  zap trash: [
        "~/.local/share/applications/wine*",
        "~/.local/share/icons/hicolor/**/application-x-wine*",
        "~/.local/share/mime/application/x-wine*",
        "~/.local/share/mime/packages/x-wine*",
        "~/.wine",
        "~/.wine32",
        "~/Library/Saved Application State/org.winehq.wine-devel.wine.savedState",
      ],
      rmdir: [
        "~/.local/share/applications",
        "~/.local/share/icons",
        "~/.local/share/mime",
      ]

  caveats <<~EOS
    Please follow the instructions in the Game Porting Toolkit README to complete installation.
  EOS
  caveats do
    requires_rosetta
  end
end
