{ ... }:
{
  flake.nixosModules.gaming = { pkgs, ... }: {
      programs.steam.enable = true;
      programs.gamemode.enable = true;
      programs.steam.protontricks.enable = true;
      environment.systemPackages = with pkgs; [
        protonup-ng
        lutris
        vulkan-tools
    ];
  };
}

