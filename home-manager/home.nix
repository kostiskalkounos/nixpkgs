{ nixpkgs-unstable, ... }:
{ config, pkgs, ... }:
let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = with pkgs; [
    bash
    bat
    boost
    cmake
    coreutils
    dos2unix
    fd
    fzf
    gdb
    git
    git-delta
    gnu-sed
    google-java-format
    gotop
    htop
    jdtls
    jq
    lf
    libuv
    libvterm
    llvm
    luarocks
    maven
    neovim
    ninja
    node
    openjdk
    pkg-config
    qemu
    ranger
    ripgrep
    stow
    stylua
    tmux
    tree
    unibilium
    zsh

    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    # niv # easy dependency management for nix projects
    nix-output-monitor # get additional information while building packages
    nix-tree # interactively browse dependency graphs of Nix derivations
    nix-update # swiss-knife for updating nix packages
    nixpkgs-review # review pull-requests on nixpkgs
    # node2nix # generate Nix expressions to build NPM packages
    # statix # lints and suggestions for the Nix programming language
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # home.username = builtins.getEnv "USER";
  # home.homeDirectory = builtins.getEnv "HOME";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    # PAGER = "nvim -R";
    # MANPAGER = "nvim +Man!";
    # LESS = "-R --use-color Du+b";
    # MANPAGER="less -R --use-color -Dd+r -Du+b";
  };

  home.stateVersion = "23.05";

  home.file.".ideavimrc".source =
    config.lib.file.mkOutOfStoreSymlink ./configs/idea/ideavimrc;

  home.file.".hammerspoon".source =
    config.lib.file.mkOutOfStoreSymlink ./config/hammerspoon;
}
