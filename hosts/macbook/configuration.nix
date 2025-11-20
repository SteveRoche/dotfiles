{ ... }:
{
  imports = [
    ../../common/settings.nix
    ../../common/system-packages.nix
  ];

  system.stateVersion = 4;

  nix.extraOptions = ''
    extra-platforms = aarch64-darwin
  '';
  nix.gc.interval = { Weekday = 0; Hour = 0; Minute = 0; };
  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.steve.home = "/Users/steve";
  system.primaryUser = "steve";
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  networking.hostName = "macbook";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    taps = [
      "cfergeau/crc"
    ];
    brews = [
      "vfkit"
      "ghcup"
    ];
    casks = [
      "alt-tab"
      "anaconda"
      "balenaetcher"
      "betterdisplay"
      "blender"
      "bunch"
      "calibre"
      "db-browser-for-sqlite"
      "discord"
      "ghostty"
      "github"
      "grandperspective"
      "imhex"
      "isabelle"
      "keepingyouawake"
      "linear-linear"
      "mac-mouse-fix"
      "microsoft-outlook"
      "numi"
      "obsidian"
      "orion"
      "pomatez"
      "proton-drive"
      "proton-mail"
      "proton-mail-bridge"
      "proton-pass"
      "protonvpn"
      "steam"
      "sublime-text"
      "ticktick"
      "visual-studio-code"
      "whatsapp"
      "yt-music"
      "zotero"
    ];
  };
  system.defaults = {
    NSGlobalDomain = {
      ApplePressAndHoldEnabled = false;
      NSWindowShouldDragOnGesture = true;
    };
    dock = {
      autohide = true;
      mru-spaces = false;
      magnification = true;
      persistent-apps = [
        "/Applications/Orion.app"
        "/Applications/Proton Mail.app"
        "/Applications/Microsoft Outlook.app"
        { spacer = { small = true; }; }
        "/Applications/TickTick.app"
        "/Applications/Obsidian.app"
        { spacer = { small = true; }; }
        "/Applications/Ghostty.app"
        "/Applications/Visual Studio Code.app"
        { spacer = { small = true; }; }
        "/Applications/Zotero.app"
        "/Applications/Numi.app"
      ];
      minimize-to-application = true;
      persistent-others = [];
      show-recents = false;
      tilesize = 48;
      largesize = 72;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = true;
    };
    screensaver.askForPasswordDelay = 10; # seconds
    screencapture.location = "~/Pictures/Screenshots";
  };
}
