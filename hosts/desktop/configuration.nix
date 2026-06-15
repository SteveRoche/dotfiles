{ inputs, self, ... }:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.desktopConfiguration
      self.nixosModules.desktopHardware
      self.nixosModules.gnomeShell
      self.nixosModules.gaming
      self.nixosModules.guiApps
      self.nixosModules.firefox
      self.nixosModules.niri
      self.modules.cli
      self.modules.nix
      inputs.nix-index-database.nixosModules.default
      # inputs.omnisearch.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.steve = {
          imports = [
            self.homeConfigurations.home
            self.homeModules.gnomeShell
            self.homeModules.gpg
            self.homeModules.cli
          ];
        };
      }
    ];
  };

  flake.homeConfigurations.home = {
    home.stateVersion = "25.11";
    home.username = "steve";
    programs.home-manager.enable = true;
  };

  flake.nixosModules.desktopConfiguration =
    { pkgs, ... }:
    {
      system.stateVersion = "25.11";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_6_18;

      networking.hostName = "desktop";
      networking.networkmanager.enable = true;

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
          };
          Policy = {
            AutoEnable = true;
          };
        };
      };

      nixpkgs.overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config;
            system = pkgs.stdenv.hostPlatform.system;
          };
        })
      ];

      time.timeZone = "Australia/Sydney";
      i18n.defaultLocale = "en_AU.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
      };

      services.xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      services.printing.enable = true;
      services.power-profiles-daemon.enable = false;
      services.auto-cpufreq.enable = true;
      services.auto-cpufreq.settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      # services.omnisearch.enable = true;

      programs.direnv = {
        enable = true;
        silent = true;
      };

      # services.xserver.libinput.enable = true;

      programs.zsh.enable = true;
      programs.appimage.enable = true;
      programs.appimage.binfmt = true;
      programs.appimage.package = pkgs.appimage-run.override { extraPkgs = pkgs: [ ]; };
      programs.java = {
        enable = true;
        package = pkgs.jre8;
      };

      users.users.steve = {
        isNormalUser = true;
        description = "Steve Roche";
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
}
