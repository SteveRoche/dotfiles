{ ... }:
{
  flake.nixosModules.gnomeShell =
    { pkgs, ... }:
    {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      environment.systemPackages = with pkgs; [
        gnomeExtensions.vicinae
        gnomeExtensions.keep-awake
        gnomeExtensions.quick-settings-audio-panel
        gnomeExtensions.dash-to-dock
      ];

      # From https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
      environment.gnome.excludePackages = with pkgs; [
        # baobab      # disk usage analyzer
        epiphany # web browser
        gedit # text editor
        simple-scan # document scanner
        totem # video player
        yelp # help viewer
        evince # document viewer
        # file-roller # archive manager
        # nautilus    # file browser
        geary # email client
        seahorse # password manager
        orca # screen reader

        gnome-calculator
        gnome-calendar
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-photos
        gnome-system-monitor
        gnome-connections
        gnome-clocks
        gnome-text-editor
        gnome-tour
        gnome-console
        gnome-weather
        # gnome-characters gnome-screenshot gnome-disk-utility
      ];

      programs.dconf.profiles.user.databases = [
        {
          settings = {
            "org/gnome/shell" = {
              enabled-extensions = with pkgs.gnomeExtensions; [
                vicinae.extensionUuid
                keep-awake.extensionUuid
                quick-settings-audio-panel.extensionUuid
                dash-to-dock.extensionUuid
              ];
            };
            "org/gnome/shell/app-switcher" = {
              current-workspace-only = true;
            };
            "org/gnome/shell/extensions/dash-to-dock" = {
              dock-position = "BOTTOM";
              show-show-apps-button = false;
              middle-click-action = "launch";
              shift-click-action = "minimize";
              intellihide = false;
            };
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              accent-color = "green";
              enable-hot-corners = false;
            };
          };
          # lockAll = true;
        }
      ];
    };

  flake.homeModules.gnomeShell =
    { pkgs, ... }:
    {
      programs.vicinae = {
        enable = true;
        systemd.enable = true;
      };

      services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
    };
}
