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
        obsidian
        proton-pass
        protonmail-desktop
        sioyek
        vscode
        zed-editor
        unstable.zotero
      ];
    };
}
