{ config, pkgs, lib, ... }:

let 
  # nigpkgsRev = "staging-next";
  # pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

  firefox-darwin = pkgs.callPackage ./firefox.nix {};
  _1password-gui = pkgs.callPackage ./1password.nix {};
  rectangle = pkgs.callPackage ./rectangle.nix {};

  vscode-monochrome  = pkgs.callPackage ./vscode/monochrome.nix {};
  vscode-monochrome-dark  = pkgs.callPackage ./vscode/monochrome-dark.nix {};

  pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};

  externalPackages = import ./packages.nix { inherit pkgs; };
  allPackages = externalPackages ++ [firefox-darwin _1password-gui rectangle];

  # temporary fix until in latest release
  ipythonFix = self: super: {
    python3 = super.python3.override {
      packageOverrides = pySelf: pySuper: {
        ipython = pySuper.ipython.overridePythonAttrs (old: {
          preCheck = old.preCheck + super.lib.optionalString super.stdenv.isDarwin ''
            echo '#!${pkgs.stdenv.shell}' > pbcopy
            chmod a+x pbcopy
            cp pbcopy pbpaste
            export PATH="$(pwd)''${PATH:+":$PATH"}"
          '';
        });
      };
      self = self.python3;
    };
  };
in
{
  nixpkgs = {
    overlays = [ipythonFix];

    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      allowBroken = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  programs = {
    alacritty = import ./alacritty.nix;

    direnv = {
      enable = true;
      
      nix-direnv = {
        enable = true;
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    firefox = {
      enable = true;
      package = firefox-darwin;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        unpaywall
        reddit-enhancement-suite
        react-devtools
      ];
      # extraPolicies = {
      #   DisableFirefoxStudies = true;
      #   DisablePocket = true;
      #   DisableTelemetry = true;
      #   DisableFirefoxAccounts = true;
      #   FirefoxHome = {
      #     Pocket = false;
      #     Snippets = false;
      #   };
      #   UserMessaging = {
      #     ExtensionRecommendations = false;
      #     SkipOnboarding = true;
      #   };
      # };
      profiles = {
        fredrikw = {
          id = 0;
          settings = {
            "app.update.auto" = false;
            "signon.rememberSignons" = false;
          };
        };
      };
    };

    git = import ./git.nix { inherit pkgs; };

    go = {
      enable = true;
    };

    gpg = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };

    irssi = {
      enable = true;
      networks = {
        oftc = {
          nick = "frekw";
          server = {
            address = "irc.oftc.net";
            port = 6697;
            autoConnect = true;
          };
          channels = {
            nixos.autoJoin = true;
            home-manager.autoJoin = true;
          };
        };
      };
    };

    neovim = import  ./neovim.nix { vimPlugins = pkgs.vimPlugins; };

    tmux = import ./tmux.nix { inherit pkgs; };

    sbt = {
      enable = true;
    };

    ssh = {
      enable = true;
      extraConfig = ''
      IgnoreUnknown UseKeychain
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
      '';
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        vspacecode.whichkey
        vspacecode.vspacecode
        brettm12345.nixfmt-vscode
        jnoortheen.nix-ide
        scalameta.metals
        vscode-monochrome
        vscode-monochrome-dark
      ];
    };

    zsh = import ./zsh.nix {  inherit pkgs; };
  };

  home = {
    username = "fredrikw";
    homeDirectory = "/Users/fredrikw";
    stateVersion = "22.05";
    packages = allPackages;
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };
  };
}
