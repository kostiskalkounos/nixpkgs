{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/yabai";
in
{
  xdg.configFile."yabai/yabairc".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/yabairc";
}
