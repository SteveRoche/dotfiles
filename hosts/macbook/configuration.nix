{ inputs, self, ... }: {
  flake.darwinConfigurations.macbook = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      {
        nixpkgs.overlays = [
          (final: prev: { # Overlay to disable tests in direnv until upstream is fixed https://github.com/NixOS/nixpkgs/issues/507531
            direnv = prev.direnv.overrideAttrs (oldAttrs: {
              doCheck = false;
            });
          })
        ];
      }
      self.darwinModules.macbookConfiguration
      self.darwinModules.guiApps
      self.modules.cli
      self.modules.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.steve = {
          imports = [
            self.homeModules.macbookHome
            self.homeModules.cli
          ];
        };
      }
    ];
  };

  flake.homeModules.macbookHome = {
    home.stateVersion = "25.11";
    home.homeDirectory = "/Users/steve";
  };

  flake.darwinModules.macbookConfiguration = { ... }: {
    imports = [];

    system.stateVersion = 4;

    nixpkgs.hostPlatform = "aarch64-darwin";
    nix.extraOptions = ''
      extra-platforms = aarch64-darwin
    '';

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
    };

    programs.direnv = {
      enable = true;
      silent = true;
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
          "/Applications/Helix.app"
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
  };
}
