{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nixpkgs/home-manager/karabiner";
in
{
  xdg.configFile."karabiner/karabiner.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/karabiner.json";
  xdg.configFile."karabiner/assets/complex_modifications/arrow-keys.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/arrow-keys.json";
  xdg.configFile."karabiner/assets/complex_modifications/caps-lock.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/caps-lock.json";
  xdg.configFile."karabiner/assets/complex_modifications/delete-word.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/delete-word.json";
  xdg.configFile."karabiner/assets/complex_modifications/double-shift.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/double-shift.json";
  xdg.configFile."karabiner/assets/complex_modifications/hyper.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dir}/hyper.json";
}
