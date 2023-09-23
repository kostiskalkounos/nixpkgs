{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/karabiner";
in
{
  xdg.configFile."bat/config".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/config";
  xdg.configFile."bat/themes/Onedark.tmTheme".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/Onedark.tmTheme";
}
