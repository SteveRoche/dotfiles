{ ... }:
{
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    qt.enable = true;

    environment.systemPackages = with pkgs; [
      noctalia-shell
      xwayland-satellite
      swayimg
      papirus-icon-theme
      nemo
      fuzzel
      gpu-screen-recorder
      wl-clipboard
      libsForQt5.qt5ct
    ];
  };
}
