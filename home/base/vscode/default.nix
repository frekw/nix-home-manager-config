{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      # vscode-monochrome
      brettm12345.nixfmt-vscode
      github.copilot
      elixir-lsp.vscode-elixir-ls
      graphql.vscode-graphql
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
      {
        name = "sapling-scm";
        publisher = "meta";
        version = "0.1.36";
        sha256 = "sha256-STRTh2RftqAb1OIn5eBVAGjZVZO6DpAUl0rnYCDzbII=";
      }
      {
        name = "gti-vscode";
        publisher = "Graphite";
        version = "0.5.4";
        sha256 = "sha256-mD6bLyToVcckADdUbj1s973As+DSnPsJLMjDv3omO6I=";
      }
      {
        name = "toml";
        publisher = "be5invis";
        version = "0.6.0";
        sha256 = "sha256-yk7buEyQIw6aiUizAm+sgalWxUibIuP9crhyBaOjC2E=";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2024.3.10601007";
        sha256 = "sha256-7BmzlsgsCOUvEVhiIL6v7ItvVOqqfTsdEMZYieurmyc=";
      }
      # {
      #   publisher = "github";
      #   name = "copilot";
      #   version = "1.158.0";
      #   sha256 = "sha256-W1j1VAuSM1sgxHRIahqVncUlknT+MPi7uutY+0NURZQ=";
      # }
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
      "metals.serverVersion" = "1.2.0+106-c6ab0475-SNAPSHOT";

      "github.copilot.enable" = {
        "*" = true;
        "yaml" = true;
        "plaintext" = false;
        "markdown" = false;
        "scala" = true;
        "go" = true;
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
}