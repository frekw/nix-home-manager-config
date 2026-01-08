{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          # ms-python.python
          bazelbuild.vscode-bazel
          bradlc.vscode-tailwindcss
          brettm12345.nixfmt-vscode
          elixir-lsp.vscode-elixir-ls
          elixir-lsp.vscode-elixir-ls
          esbenp.prettier-vscode
          github.copilot
          github.copilot-chat
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
          rust-lang.rust-analyzer
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
            name = "moonbit-lang";
            publisher = "moonbit";
            version = "0.1.202505082";
            sha256 = "sha256-ur5kFmdL8E9wVjFT9z52+JUddi0ypv5PHExqLhQUnEk=";
          }
          {
            name = "triggertaskonsave";
            publisher = "Gruntfuggly";
            version = "0.2.17";
            sha256 = "sha256-ax/hkewlH0K+sLkFAvgofD6BjEheRYObAAvt8MA3pqc=";
          }
        ];

      userSettings = {
        "update.mode" = "none";

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
        "metals.serverVersion" = "1.6.3";
        "metals.javaHome" = "${pkgs.jdk}";

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

        "github.copilot.inlineSuggest.enable" = true;
        "github.copilot.enable" = {
          "*" = true;
          "yaml" = true;
          "scala" = true;
          "go" = true;
          "terraform" = true;
          "plaintext" = false;
          "markdown" = false;
        };

        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      }
      // (
        if pkgs.stdenv.hostPlatform.isDarwin then
          {
            "dev.containers.dockerPath" = "podman";
          }
        else
          { }
      );
    };
  };
}
