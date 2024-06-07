{ pkgs, roc, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    extensions =
      with pkgs.vscode-extensions;
      [
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
        vscodevim.vim
        vspacecode.vspacecode
        vspacecode.whichkey
        zxh404.vscode-proto3
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-elixir";
          publisher = "mjmcloug";
          version = "1.1.0";
          sha256 = "sha256-EE4x75ljGu212gqu1cADs8bsXLaToVaDnXHOqyDlR04=";
        }
        {
          name = "monochrome-dark";
          publisher = "mikehhodgson";
          version = "0.0.7";
          sha256 = "sha256-W+QNykFE5wE/huW1f+JA0+OcIBmtrbSLD/y54REqhEE=";
        }
        # {
        #   name = "monochrome";
        #   publisher = "anotherglitchinthematrix";
        #   version = "2.4.3";
        #   sha256 =
        #     "c64e184d3e9ad515bf2675a5fabeced1cdd937f95933bba212709cf61eec9997";
        # }
        # {
        #   publisher = "mogelbrod";
        #   name = "quickopener";
        #   version = "0.4.1";
        #   sha256 = "sha256-AJ3C1QdGpsobSMyu7xes+rC4EW/NravZWS60GqEKW2Y=";
        # }
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
        {
          name = "roc-lang-unofficial";
          publisher = "IvanDemchenko";
          version = "1.2.0";
          sha256 = "sha256-lMN6GlUM20ptg1c6fNp8jwSzlCzE1U0ugRyhRLYGPGE=";
        }
        {
          name = "prettier-vscode";
          publisher = "esbenp";
          version = "10.4.0";
          sha256 = "sha256-8+90cZpqyH+wBgPFaX5GaU6E02yBWUoB+T9C2z2Ix8c=";
        }
      ];

    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "nix.enableLanguageServer" = true;

      "vim.leader" = ",";
      "vim.easymotion" = true;
      "vim.useSystemClipboard" = true;
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = [ "<space>" ];
          "commands" = [ "vspacecode.space" ];
        }
        {
          "before" = [ "," ];
          "commands" = [
            "vspacecode.space"
            {
              "command" = "whichkey.triggerKey";
              "args" = "m";
            }
          ];
        }
      ];
      "vim.insertModeKeyBindings" = [
        {
          "before" = [
            "j"
            "j"
          ];
          "after" = [ "<Esc>" ];
        }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        {
          "before" = [ "<space>" ];
          "commands" = [ "vspacecode.space" ];
        }
        {
          "before" = [ "," ];
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
      "editor.fontFamily" = "Berkeley Mono";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.bracketPairColorization.enabled" = false;
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.inlayHints.enabled" = "on";
      "editor.inlayHints.fontSize" = 11;
      "editor.tokenColorCustomizations" = { };

      "metals.suggestLatestUpgrade" = true;
      "metals.serverVersion" = "1.3.0";
      "metals.javaHome" = "${pkgs.jdk}";

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

      "roc-lang.language-server.exe" = "${
        roc.packages.${pkgs.system}.lang-server
      }/bin/roc_language_server
      }";
    };
  };
}
