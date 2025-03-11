{ pkgs, roc, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          bazelbuild.vscode-bazel
          brettm12345.nixfmt-vscode
          elixir-lsp.vscode-elixir-ls
          elixir-lsp.vscode-elixir-ls
          esbenp.prettier-vscode
          github.copilot
          github.vscode-github-actions
          golang.go
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
          hashicorp.terraform
          jnoortheen.nix-ide
          mkhl.direnv
          # ms-python.python
          ocamllabs.ocaml-platform
          redhat.vscode-yaml
          # rust-lang.rust-analyzer
          scala-lang.scala
          scalameta.metals
          tamasfe.even-better-toml
          vscodevim.vim
          vspacecode.vspacecode
          vspacecode.whichkey
          zxh404.vscode-proto3
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "monochrome-dark";
            publisher = "mikehhodgson";
            version = "0.0.7";
            sha256 = "sha256-W+QNykFE5wE/huW1f+JA0+OcIBmtrbSLD/y54REqhEE=";
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
            version = "0.6.1";
            sha256 = "sha256-gGpWj1iVz6nYgMk7RuYgvIf9E8Yq0lt9PZnhLLDO7So=";
          }
          {
            name = "roc-lang-unofficial";
            publisher = "IvanDemchenko";
            version = "1.2.0";
            sha256 = "sha256-lMN6GlUM20ptg1c6fNp8jwSzlCzE1U0ugRyhRLYGPGE=";
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

        "python.analysis.typeCheckingMode" = "basic";

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

        # "roc-lang.language-server.exe" = "${
        #   roc.packages.${pkgs.system}.lang-server
        # }/bin/roc_language_server
        # }";
      };
    };
  };
}
