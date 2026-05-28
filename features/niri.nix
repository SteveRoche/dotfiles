{ inputs, ... }:
{
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    qt.enable = true;

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
