{ config, pkgs, ... }:

let 
  # nigpkgsRev = "staging-next";
  # pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};


  firefox-darwin = pkgs.callPackage ./firefox.nix {};
  _1password-gui = pkgs.callPackage ./1password.nix {};
  rectangle = pkgs.callPackage ./rectangle.nix {};
in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    allowBroken = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };

    alacritty = import ./alacritty.nix;

    git = import ./git.nix { inherit pkgs; };

    exa = {
      enable = true;
      enableAliases = true;
    };

    direnv = {
      enable = true;
      
      nix-direnv = {
        enable = true;
      };
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

    gpg = {
      enable = true;
    };

    neovim = import  ./neovim.nix { vimPlugins = pkgs.vimPlugins; };

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

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        vspacecode.whichkey
        vspacecode.vspacecode
        brettm12345.nixfmt-vscode
        jnoortheen.nix-ide
      ];
    };

    go = {
      enable = true;
    };
  };

  home = {
    username = "fredrikw";
    homeDirectory = "/Users/fredrikw";
    stateVersion = "22.05";
    packages = [
      pkgs.keybase
      pkgs.slack
      pkgs.rnix-lsp
      pkgs.nixfmt
      pkgs._1password
      _1password-gui
      rectangle
      pkgs.fira-code
      (pkgs.nerdfonts.override { fonts = ["FiraCode"]; })
    ];
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };
  };
}
