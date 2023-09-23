{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/ripgrep";
in
{
  xdg.configFile."ripgrep/.ripgreprc".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/.ripgreprc";
}
