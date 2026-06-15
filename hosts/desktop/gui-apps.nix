{ ... }:
{
  flake.nixosModules.guiApps =
    { pkgs, ... }:
    {
      imports = [ ];

      environment.systemPackages = with pkgs; [
        blender
        discord
        ghostty
        jetbrains.clion
        linear
        obsidian
        proton-pass
        protonmail-desktop
        sioyek
        unstable.zotero
        vscode
        zed-editor
      ];
    };
}
