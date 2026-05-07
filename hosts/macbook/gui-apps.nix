{ inputs, self, ... }: {
  flake.darwinModules.guiApps = { ... }: {
    imports = [];

    homebrew.casks = [
      "alt-tab"
      # "anaconda"
      # "balenaetcher"
      "betterdisplay"
      "blender"
      "clion"
      "calibre"
      "db-browser-for-sqlite"
      "discord"
      "ghostty"
      "github"
      "grandperspective"
      "helium-browser"
      "imhex"
      "isabelle"
      "keepingyouawake"
      "linear-linear"
      "mac-mouse-fix"
      "microsoft-outlook"
      "numi"
      "obsidian"
      "pomatez"
      "proton-drive"
      "proton-mail"
      "proton-mail-bridge"
      "proton-pass"
      "protonvpn"
      "steam"
      "ticktick"
      "visual-studio-code"
      "whatsapp"
      "yt-music"
      "zotero"
    ];
  };
}
