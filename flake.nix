{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, ... }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.vim
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      programs.zsh.promptInit = "";
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      nixpkgs.config.allowUnfree = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
      mac = "x86_64-darwin";
      work = "x86_64-darwin";
      linux = "x86_64-linux"
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#kali
    darwinConfigurations."kali" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."kali".pkgs;
    darwinConfigurations = {
      mac = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          (import ./darwin/configuration.nix inputs)
          {
            # `home-manager` config
            # home-manager.useGlobalPkgs = true;
            # home-manager.useUserPackages = true;
            home-manager.users.${user.mac}.imports =
              [
                (import ./home-manager/home.nix inputs)
                ./home-manager/modules/alacritty.nix
                # ./home-manager/modules/osx.nix
                ./home-manager/modules/cli.nix
                ./home-manager/modules/git.nix
                ./home-manager/modules/gpg.nix
                ./home-manager/modules/kitty.nix
                (import ./home-manager/modules/neovim.nix inputs)
                ./home-manager/modules/python.nix
                ./home-manager/modules/ssh.nix
                (import ./home-manager/modules/tmux.nix inputs)
                ./home-manager/machines/personal.nix
              ];
            # inherit pkgs;
          }
        ];
        system = system.mac;
      };

      work = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          (import ./darwin/work-configuration.nix inputs)
          {
            home-manager.users.${user.work}.imports =
              [
                (import ./home-manager/home.nix inputs)
                ./home-manager/modules/alacritty.nix
                ./home-manager/modules/cli.nix
                ./home-manager/modules/git.nix
                ./home-manager/modules/gpg.nix
                ./home-manager/modules/kitty.nix
                (import ./home-manager/modules/neovim.nix inputs)
                ./home-manager/modules/python.nix
                (import ./home-manager/modules/tmux.nix inputs)
                ./home-manager/machines/work.nix
              ];
          }
        ];
        system = system.work;
      };
    };
    nixosConfigurations = {
      nixos-raspbi = inputs.nixpkgs-nixos.lib.nixosSystem {
        system = system.raspbi;
        modules = [
          ./nixos/configuration.nix
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ];
      };
    };

  };
}
