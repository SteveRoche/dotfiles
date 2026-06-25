{ ... }:
{
  flake.modules.cli =
    { lib, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        btop
        cloc
        fd
        fzf
        gnupg
        jq
        just
        fastfetch
        nps
        pdftk
        ripgrep
        starship
        tree
        unzip
        watchexec
        wget
        yazi
        zoxide
        zip

        man-pages
        man-pages-posix

        gitFull
        git-extras
        gh
        glab
        lazygit
        jujutsu

        unstable.neovim
        tree-sitter

        typst
        tinymist
        typstyle

        python313
        python313Packages.pynvim

        nil
        nixd
        alejandra

        lua51Packages.lua
        lua51Packages.luarocks
        lua-language-server
        stylua

        unstable.zig
        unstable.zls

        go
        gopls

        ## C/C++
        cmake
        lldb_20
        clang_20
        gnumake

        ## Shell scripting
        shellcheck
      ];
    };

  flake.homeModules.cli =
    { ... }:
    {
      home.file = {
        ".zshenv".source = ./home/zshenv;
        ".config/zsh/.zshrc".source = ./home/zshrc;
        ".config/git/config".source = ./home/git;
        ".config/nvim/init.lua".source = ./home/nvim/init.lua;
        ".config/ghostty/config".source = ./home/ghostty/config;
      };

      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };
}
