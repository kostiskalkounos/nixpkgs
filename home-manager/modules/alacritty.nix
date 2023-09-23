{ config, pkgs, libs, ... }:

let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/alacritty";
in
{
  xdg.configFile."alacritty/alacritty.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/alacritty.yml";
}

