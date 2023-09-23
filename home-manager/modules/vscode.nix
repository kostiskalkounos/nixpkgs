{ nixpkgs-unstable, ... }:
{ config, pkgs, ... }:
let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  xdg.configFile."vscode".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/home-manager/config/vscode";
}
