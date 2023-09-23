{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/ranger";
in
{
  xdg.configFile."ranger/rc.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/rc.conf";
}
