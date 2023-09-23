{ nixpkgs-unstable, ... }:
{ config, pkgs, ... }:
let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = with pkgs; [
    gopls
    lua
    # neovim-nightly
    unstable.neovim
    nil
    nixfmt
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint
    nodePackages.pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodejs
    stylua
    sumneko-lua-language-server
    yarn
  ];
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/home-manager/config/nvim";
}
