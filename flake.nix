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

    nixpkgs-old-tf.url =
      "github:nixos/nixpkgs/39ed4b64ba5929e8e9221d06b719a758915e619b";

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

    rycee-ff = {
      url = "sourcehut:~rycee/nur-expressions?dir=pkgs/firefox-addons";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, nix-homebrew
    , homebrew-bundle, homebrew-core, homebrew-cask, rycee-ff, ... }@inputs:
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
      genSpecialArgs = system:
        inputs // rec {
          inherit user;

          pkgs = import inputs.nixpkgs {
            # refer the `system` parameter form outer scope recursively
            inherit system;
            config.allowUnfree = true;
          };

          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
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
            inherit
              system; # refer the `system` parameter form outer scope recursively
            config.allowUnfree = true;
          };

          mypkgs = import ./pkgs { pkgs = pkgs; };
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
        m1 = let specialArgs = genSpecialArgs "aarch64-darwin";
        in nix-darwin.lib.darwinSystem {
          inherit inputs;

          system = "aarch64-darwin";
          specialArgs = specialArgs;
          modules = [
            ./hosts/m1
            ./modules/darwin
            ./modules/darwin/brew.nix

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users."${user.username}" = import ./home/darwin;
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

      nixosConfigurations = { };
    };
}
