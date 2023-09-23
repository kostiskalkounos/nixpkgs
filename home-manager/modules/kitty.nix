{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/kitty";
in
{
  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/kitty.conf";
  xdg.configFile."kitty/mappings.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/mappings.conf";
  xdg.configFile."kitty/onedark.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/onedark.conf";
  xdg.configFile."kitty/symbols.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/symbols.conf";
  xdg.configFile."kitty/scrollback-pager/nvim/init.vim".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/scrollback-pager/nvim/init.vim";
}

