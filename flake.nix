{
  # Very inspired by:
  # - https://github.com/dustinlyons/nixos-config
  # - https://github.com/reckenrode/nixos-configs
  # - https://github.com/ryan4yin/nix-config

  description = "frekw's Nix configuration";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      follows = "nixos-cosmic/nixpkgs"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

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

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rycee-ff = {
      url = "sourcehut:~rycee/nur-expressions?dir=pkgs/firefox-addons";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
    };

    roc = {
      url = "github:roc-lang/roc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # private flake
    fonts = {
      url = "git+ssh://git@github.com/frekw/fonts.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      nixos-cosmic,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      nix-alien,
      rycee-ff,
      agenix,
      kmonad,
      roc,
      fonts,
      colmena,
      ...
    }@inputs:
    let
      user = {
        name = "Fredrik Wärnsberg";
        username = "fredrikw";
      };
      darwinSystems = {
        aarch64-darwin = "aarch64-darwin";
      };
      linuxSystems = {
        x86_64-linux = "x86_64-linux";
      };
      allSystems = darwinSystems // linuxSystems;
      allSystemNames = builtins.attrNames allSystems;
      forAllSystems = f: (nixpkgs.lib.genAttrs allSystemNames f);
      specialArgs = inputs // {
        inherit user;
      };
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              zsh
              git
              alejandra
            ];
            name = "dotfiles";
            shellHook = ''
              export EDITOR=vim
            '';
          };
        }
      );

      darwinConfigurations = {
        m1 = nix-darwin.lib.darwinSystem {
          inherit inputs;

          system = "aarch64-darwin";
          specialArgs = specialArgs;
          modules = [
            ./hosts/m1
            ./modules/darwin
            ./modules/darwin/brew.nix
            ./pkgs

            agenix.darwinModules.default
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
                enableRosetta = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                # autoMigrate = true;
              };
            }
          ];
        };
      };

      nixosConfigurations = {
        um790 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            ./hosts/um790
            ./modules/linux
            ./modules/linux/gui
            ./pkgs

            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            kmonad.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users."${user.username}" = import ./home/linux;
            }
            nixos-cosmic.nixosModules.default
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
          ];
        };

        naus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            agenix.nixosModules.default
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            ./hosts/naus
            ./pkgs
          ];
        };
      };

      colmenaHive = colmena.lib.makeHive self.outputs.colmena;
      colmena = {
        meta =
          let
            pkgs = import inputs.nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          in
          {
            nixpkgs = pkgs;
            specialArgs = specialArgs;
          };

        defaults =
          { pkgs, ... }:
          {
            environment.systemPackages = with pkgs; [
              curl
              gitMinimal
              zsh
            ];
          };

        naus = {
          deployment = {
            targetHost = "192.168.68.53";
            targetPort = 22;
            buildOnTarget = true;
            targetUser = "root";
            tags = [ "homelab" ];
          };
          time.timeZone = "Europe/Stockholm";

          imports = [
            agenix.nixosModules.default
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            ./hosts/naus
            ./pkgs
          ];
        };
      };
    };
}
