{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrappers.url = "github:Lassulus/wrappers";
    wrapper-modules.url = "github:Birdeehub/nix-wrapper-modules";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      inherit (lib.fileset) toList fileFilter;
      isNixModule = file: file.hasExt "nix" && file.name != "flake.nix" && !lib.hasPrefix "_" file.name;
      importTree = path: toList (fileFilter isNixModule path);
      mkFlake = inputs.flake-parts.lib.mkFlake { inherit inputs; };
    in
    mkFlake {
      imports = importTree ./.;
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    };
}
