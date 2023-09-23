{ nixpkgs-unstable, ... }:
{ config, pkgs, lib, ... }:
let
  user = "kostis";
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  homebrew = {
    enable = true;
    # global.autoUpdate = false;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      "koekeishiya/formulae"
    ];

    brews = [ "koekeishiya/formulae/yabai" ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "alfred"
      "basictex"
      "brave-browser"
      "docker"
      "firefox"
      "font-symbols-only-nerd-font"
      "hammerspoon"
      "karabiner-elements"
      "kitty"
      "signal"
      "spotify"
      "visual-studio-code"
      "whatsapp"
      "zoom"
    ];

    masApps = {
      "Dark Mode for Safari" = 1397180934;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
      Vimari = 1480933944;
    };

  };

  networking.hostName = "kali";

  system.defaults = {
    dock.autohide = true;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  # system.keyboard.remapCapsLockToEscape = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.configureBuildUsers = true;

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    trusted-users = [ "@admin" ];

    # experimental-features = [
    #      "nix-command"
    #      "flakes"
    #    ];

    keep-derivations = true;
    keep-outputs = true;
  };
}

