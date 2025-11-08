{ lib, pkgs, unstable, ... }: {
  environment.systemPackages = with pkgs; [
    home-manager

    # CLI
    btop
    cloc
    fd
    fzf
    jq
    just
    neofetch
    pdftk
    ripgrep
    starship
    tree
    unzip
    watchexec
    wget
    yazi
    zoxide

    # Man pages
    man-pages
    man-pages-posix

    # Git
    gitFull
    git-extras
    gh
    lazygit
    jujutsu

    # Editor
    neovim
    tree-sitter

    # Languages

    ## Typst
    typst
    tinymist
    typstyle

    ## Python
    python313
    python313Packages.pynvim

    ## Nix
    nil
    alejandra

    ## Rust
    rustup
    rust-analyzer

    ## Lua
    lua51Packages.lua
    lua51Packages.luarocks
    lua-language-server
    stylua

    ## Zig
    unstable.zig
    unstable.zls
    shaderc

    ## Go
    go
    gopls

    ## C/C++
    cmake
    lldb_18

    ## DotNet (for Dafny)
    dotnet-sdk

    # Containerization
    podman
    podman-compose
  ];

  # Install all nerd-fonts
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
