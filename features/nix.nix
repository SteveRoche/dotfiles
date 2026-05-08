{ inputs, ... }:
{
  flake.modules.nix = {
    nixpkgs.config.allowUnfree = true;
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
    };
    nix.gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
