{
  # Very inspired by:
  # - https://github.com/dustinlyons/nixos-config
  # - https://github.com/reckenrode/nixos-configs
  # - https://github.com/ryan4yin/nix-config

  description = "frekw's Nix configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nixpkgs-old-tf.url = "github:nixos/nixpkgs/39ed4b64ba5929e8e9221d06b719a758915e619b";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = { url = "github:zhaofengli-wip/nix-homebrew"; };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, nur, ... }@inputs:
    let
      user = {
        name = "Fredrik Wärnsberg";
        username = "fredrikw";
      };
      darwinSystems = { aarch64-darwin = "aarch64-darwin"; };
      linuxSystems = { x86_64-linux = "x86_64-linux"; };
      allSystems = darwinSystems // linuxSystems;
      allSystemNames = builtins.attrNames allSystems;
      forAllSystems = f: (nixpkgs.lib.genAttrs allSystemNames f);
      mypkgs = import ./packages/top-level/all-modules.nix { inherit (nixpkgs) lib; };
      genSpecialArgs = system: inputs // {
        inherit user nur mypkgs;

        pkgs-unstable = import inputs.nixpkgs-unstable {
          inherit system; # refer the `system` parameter form outer scope recursively
          config.allowUnfree = true;
        };
        pkgs-stable = import inputs.nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-master = import inputs.nixpkgs-master {
          inherit system;
          config.allowUnfree = true;
        };
        pkgs-old-tf = import inputs.nixpkgs-old-tf {
          inherit system; # refer the `system` parameter form outer scope recursively
          config.allowUnfree = true;
        };
      };

    in {
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ zsh git alejandra ];
            name = "dotfiles";
            shellHook = ''
              export EDITOR=vim
            '';
          };
        });

      darwinConfigurations = {
        m1 = nix-darwin.lib.darwinSystem {
          inherit inputs;

          specialArgs = genSpecialArgs "aarch64-darwin";

          system = "aarch64-darwin";
          modules = [
            ./hosts/m1
            ./modules/darwin
            ./home/darwin

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = self.specialArgs;
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = user.username;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
          ];
        };
      };

      # hosts/
      #  - m1/
      # home-manager/
      #  - base/
      #    - tmux.nix
      #  - darwin/
      #    - brew/
      #  - linux/
      # system/
      #  - darwin/
      #  - linux/

      nixosConfigurations = { };
    };
}
