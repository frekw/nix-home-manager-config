{ config, pkgs, lib, ... }:

let 
  unstable = import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz") { config = config.nixpkgs.config; };

  firefox-darwin = pkgs.callPackage ./packages/firefox.nix {};
  _1password-gui = pkgs.callPackage ./packages/1password.nix {};
  rectangle = pkgs.callPackage ./packages/rectangle.nix {};

  vscode-monochrome  = pkgs.callPackage ./vscode/monochrome.nix {};
  vscode-monochrome-dark  = pkgs.callPackage ./vscode/monochrome-dark.nix {};
  vscode-copilot = pkgs.callPackage ./vscode/copilot.nix {};
  vscode-quickopener = pkgs.callPackage ./vscode/quickopener.nix {};

  externalPackages = import ./packages.nix { inherit pkgs unstable; };
  allPackages = externalPackages ++ [firefox-darwin _1password-gui rectangle];
in
{
  nixpkgs = {
    # overlays = [ipythonFix];

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
            "browser.casting.enabled" = true;
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
        # vscode-monochrome
        brettm12345.nixfmt-vscode
        # github.copilot
        graphql.vscode-graphql
        vscode-copilot
        golang.go
        jnoortheen.nix-ide
        scala-lang.scala
        scalameta.metals
        vscode-monochrome-dark
        vscode-quickopener
        vscodevim.vim
        vspacecode.vspacecode
        vspacecode.whichkey
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
