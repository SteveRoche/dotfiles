{ lib, flake-parts-lib, ... }: {
  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      darwinModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = {};
      };
      modules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = {};
      };
      homeModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = {};
      };
    };
  };
}
