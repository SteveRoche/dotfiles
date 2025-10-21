{ ... }:
{
  programs.home-manager.enable = true;
  home.username = "steve";
  home.stateVersion = "25.05";

  home.file = {
    ".zshrc".source = ./config/zshrc;
    ".config/git/config".source = ./config/git;
    ".config/nvim/init.lua".source = ./config/nvim/init.lua;
    ".config/ghostty/config".source = ./config/ghostty/config;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
