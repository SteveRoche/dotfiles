{pkgs, ...}: {
  imports = [
    ../../common/home.nix
  ];
  home.homeDirectory = "/home/steve";
  home.packages = with pkgs; [
    proton-pass
    protonmail-desktop
    zotero
    ghostty
    neovide
    obsidian
    qutebrowser
    ungoogled-chromium
    vscode
    zathura
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.file = {
    ".config/wofi".source = ./config/wofi;
    ".config/hypr".source = ./config/hypr;
  };

  fonts.fontconfig.enable = true;
}
