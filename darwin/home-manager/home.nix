{ config, pkgs, lib, ... }:

let 
  unstable = import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz") { config = config.nixpkgs.config; };

  firefox-darwin = pkgs.callPackage ./packages/firefox.nix {};

  vscode-elixir = pkgs.callPackage ./vscode/elixir.nix {};
  vscode-monochrome  = pkgs.callPackage ./vscode/monochrome.nix {};
  vscode-monochrome-dark  = pkgs.callPackage ./vscode/monochrome-dark.nix {};
  vscode-copilot = pkgs.callPackage ./vscode/copilot.nix {};
  vscode-quickopener = pkgs.callPackage ./vscode/quickopener.nix {};

  externalPackages = import ./packages.nix { inherit pkgs unstable; };
  allPackages = externalPackages ++ [firefox-darwin];
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

    eza = {
      enable = true;
      enableAliases = true;
    };

    firefox = {
      enable = true;
      package = firefox-darwin;
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
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            istilldontcareaboutcookies
            react-devtools
            reddit-enhancement-suite
            ublock-origin
            unpaywall
          ];
        };
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    gh = {
      enable = true;
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

    java = {
      enable = true;
      # package = pkgs.graalvm19-ce;
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

    # starship = {
    #   enable = true;
    #   enableZshIntegration = true;
    #   settings = {
    #     add_newline = false;
    #     format = lib.concatStrings [
    #       "$username"
    #       "$hostname"
    #       "$directory"
    #       "$git_branch"
    #       "$git_state"
    #       "$git_status"
    #       "$cmd_duration"
    #       "$character"
    #     ];
    #     directory = {
    #       style = "blue";
    #     };
    #     scan_timeout = 10;
    #     character = {
    #       success_symbol = "[❯](purple)";
    #       error_symbol = "[❯](red)";
    #       vimcmd_symbol = "[❮](green)";
    #     };
    #     git_branch = {
    #       format = "[$branch]($style)";
    #       style = "bright-black";
    #     };
    #     git_status = {
    #       format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
    #       style = "cyan";
    #       conflicted = "​";
    #       untracked = "​";
    #       modified = "​";
    #       staged = "​";
    #       renamed = "​";
    #       deleted = "​";
    #       stashed = "≡";
    #     };
    #     git_state = {
    #       format = lib.concatStrings [
    #         "\([$state( $progress_current/$progress_total)]($style)\) "
    #       ];
    #       style = "bright-black";
    #     };
    #     cmd_duration = {
    #       format = "[$duration]($style) ";
    #       style = "yellow";
    #     };
    #   };
    # };

    vscode = {
      enable = true;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [
        # vscode-monochrome
        brettm12345.nixfmt-vscode
        # github.copilot
        elixir-lsp.vscode-elixir-ls
        graphql.vscode-graphql
        vscode-copilot
        golang.go
        hashicorp.terraform
        jnoortheen.nix-ide
        matklad.rust-analyzer
        ocamllabs.ocaml-platform
        scala-lang.scala
        scalameta.metals
        vscode-elixir
        vscode-monochrome-dark
        vscode-quickopener
        vscodevim.vim
        vspacecode.vspacecode
        vspacecode.whichkey
        zxh404.vscode-proto3
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "apc-extension";
          publisher = "drcika";
          version = "0.3.0";
          sha256 = "sha256-do3QYBq83XcqD2jSMC+q+2mQHPiodpDA+OJdT0Zh7uc=";
        }
        {
          name = "vscode-bazel";
          publisher = "BazelBuild";
          version = "0.7.0";
          sha256 = "sha256-/a34MMsHy7zmGrVAtjMWKmulwS+lip3J1YugkACMmxc=";
        }
        {
          name = "graphql";
          publisher = "mquandalle";
          version = "0.1.2";
          sha256 = "sha256-0hBtHDD/yk+EpA0A/9ovAz8SUcAoTrXAtHU4Y9MiHnw=";
        }
        {
          name = "direnv";
          publisher = "mkhl";
          version = "0.15.2";
          sha256 = "sha256-agJfEc4JqxKaNQhto0BfVx2Pxk809G0Ne3TqaR8mlxo=";
        }
        {
          name = "authzed";
          publisher = "chiperific";
          version = "1.1.0";
          sha256 = "sha256-GmZowlnf+0JjN5ilR5aWZyR06pQKzuydhCeEWXnRvfs=";
        }
      ];
      userSettings = {
        "[nix]"."editor.tabSize" = 2;
        "nix.enableLanguageServer" = true;

        "vim.easymotion" = true;
        "vim.useSystemClipboard" = true;
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            "before" = [
              "<space>"
            ];
            "commands" = [
              "vspacecode.space"
            ];
          }
          {
            "before" = [
              ","
            ];
            "commands" = [
              "vspacecode.space"
              {
                "command" = "whichkey.triggerKey";
                "args" = "m";
              }
            ];
          }
        ];
        "vim.visualModeKeyBindingsNonRecursive" = [
          {
            "before" = [
              "<space>"
            ];
            "commands" = [
              "vspacecode.space"
            ];
          }
          {
            "before" = [
              ","
            ];
            "commands" = [
              "vspacecode.space"
              {
                "command" = "whichkey.triggerKey";
                "args" = "m";
              }
            ];
          }
        ];

        "files.watcherExclude" = {
          "**/.bloop" = true;
          "**/.metals" = true;
          "**/.ammonite" = true;
        };

        # "editor.fontFamily" = "Monaspace Neon Var";
        "editor.fontFamily" = "Berkeley Mono Variable";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.bracketPairColorization.enabled" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.enabled" = false;
        "editor.inlayHints.enabled" = "on";
        "editor.inlayHints.fontSize" = 11;
        "editor.tokenColorCustomizations" = {};

        "metals.suggestLatestUpgrade" = true;

        "github.copilot.enable" = {
          "*" = true;
          "yaml" = true;
          "plaintext" = false;
          "markdown" = false;
          "scala" = true;
        };

        "window.zoomLevel" = 1;
        "workbench.colorTheme" = "Monochrome Dark";
        "workbench.preferredDarkColorTheme" = "Monochrome Dark";
        "workbench.colorCustomizations" = {
          "[Monochrome Dark]" = {
            "editorInlayHint.foreground" = "#606060";
            "editorInlayHint.background" = "#1a1a1a";
            "editorInlayHint.typeForeground" = "#606060";
            "editorInlayHint.parameterForeground" = "#606060";
          };
        };

        "apc.activityBar" = {
          "position" = "bottom";
          "hideSettings" = true;
          "size" = 20;
        };

        "apc.statusBar" = {
          "position" = "editor-bottom";
          "height" = 22;
          "fontSize" = 12;
        };

        "apc.electron" = {
          "titleBarStyle" = "hiddenInset";
          "trafficLightPosition" = {
            "x" = 8;
            "y" = 10;
          };
        };

        "apc.header" = {
          "height" = 34;
          "fontSize" = 14;
        };

        "apc.listRow" = {
          "height" = 21;
          "fontSize" = 13;
        };
      };
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'

        -- This table will hold the configuration.
        local config = {}

        -- In newer versions of wezterm, use the config_builder which will
        -- help provide clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- This is where you actually apply your config choices

        -- For example, changing the color scheme:
        config.color_scheme = 'Dark Pastel'

        -- config.font = wezterm.font('Monaspace Neon')
        config.font = wezterm.font('Berkeley Mono Variable')
        config.freetype_load_flags = 'NO_HINTING'
        config.freetype_load_target = 'Normal'
        config.line_height = 1.0
        config.font_size = 16
        config.enable_tab_bar = false
        config.window_padding = {
          left = "60px",
          right = "60px",
          top = "60px",
          bottom = "60px",
        }
        config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"


        -- and finally, return the configuration to wezterm
        return config
      '';
    };

    zsh = import ./zsh.nix {  inherit pkgs; inherit config; };
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

    file = {
      "${config.xdg.configHome}/git-ps" = {
        source = ./git-ps;
        recursive = true;
      };
    };
  };
}
