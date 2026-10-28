{
  agenix,
  pkgs,
  config,
  lib,
  user,
  ...
}:
let
  # VSpaceCode-style bindings, shared by `space` (VSpaceCode root menu) and
  # `,` (VSpaceCode's major-mode menu, `space m`).
  majorMode = {
    "=" = "editor::Format";
    "a a" = "editor::ToggleCodeActions";
    "g d" = "editor::GoToDefinition";
    "g i" = "editor::GoToImplementation";
    "g r" = "editor::FindAllReferences";
    "g s" = "outline::Toggle";
    "g S" = "project_symbols::Toggle";
    "g t" = "editor::GoToTypeDefinition";
    "h h" = "editor::Hover";
    "r r" = "editor::Rename";
  };
  prefixed = prefix: lib.mapAttrs' (k: v: lib.nameValuePair "${prefix} ${k}" v) majorMode;
in
{
  options.modules.dev = {
    zed = {
      enable = lib.mkEnableOption "zed";
    };
  };

  config = lib.mkIf config.modules.dev.zed.enable {
    home-manager.users.${user.username} = {
      programs.zed-editor = {
        enable = true;
        package = pkgs.unstable.zed-editor;

        # Language servers / formatters Zed doesn't download on its own.
        extraPackages = with pkgs; [
          nil
          nixfmt
          unstable.metals
        ];

        # Ported from the VSCode "Monochrome Dark" theme.
        themes.monochrome-dark = ./themes/monochrome-dark.json;

        extensions = [
          # Counterparts to the VSCode extensions
          "authzed"
          "elixir"
          "github-actions"
          "graphql"
          "mermaid"
          "moonbit"
          "nix"
          "proto"
          "scala"
          "terraform"
          "toml"

          "helm"
          "html"
          "java"
          "ocaml"
          "sql"
          "typos"

          # themes
          "base16"
          "brook-code-theme"
          "evil-rabbit-theme"
          "gruber-darker"
          "hacker-night-vision"
          "hacker-theme"
        ];

        userKeymaps = [
          {
            context = "vim_mode == insert";
            bindings = {
              "j j" = "vim::NormalBefore";
            };
          }
          {
            # VSpaceCode. `,` is the vim leader, so easymotion's
            # `<leader><leader>` lives here too.
            context = "VimControl && !menu";
            bindings = {
              "space space" = "command_palette::Toggle";
              "space tab" = "pane::AlternateFile";
              "space '" = "terminal_panel::ToggleFocus";
              "space /" = "workspace::NewSearch";
              "space *" = [
                "workspace::SendKeystrokes"
                "v i w space /"
              ];
              "space a i" = "agent::ToggleFocus";

              "space b b" = "tab_switcher::Toggle";
              "space b d" = "pane::CloseActiveItem";
              "space b n" = "pane::ActivateNextItem";
              "space b p" = "pane::ActivatePreviousItem";
              "space b s" = "workspace::NewFile";

              "space c l" = "vim::ToggleComments";

              "space e l" = "diagnostics::Deploy";
              "space e n" = "editor::GoToDiagnostic";
              "space e p" = "editor::GoToPreviousDiagnostic";

              "space f e d" = "zed::OpenKeymap";
              "space f s" = "workspace::Save";
              "space f t" = "project_panel::ToggleFocus";
              "space f y y" = "workspace::CopyPath";

              "space g b" = "git::Blame";
              "space g l l" = "editor::OpenPermalinkToLine";
              "space g s" = "git_panel::ToggleFocus";

              "space j i" = "outline::Toggle";

              "space p f" = "file_finder::Toggle";
              "space p p" = "projects::OpenRecent";
              "space p t" = "project_panel::ToggleFocus";

              "space q q" = "workspace::CloseWindow";

              "space s s" = "buffer_search::Deploy";
              "space s p" = "workspace::NewSearch";

              "space t w" = "editor::ToggleSoftWrap";

              "space w /" = "pane::SplitRight";
              "space w -" = "pane::SplitDown";
              "space w h" = "workspace::ActivatePaneLeft";
              "space w j" = "workspace::ActivatePaneDown";
              "space w k" = "workspace::ActivatePaneUp";
              "space w l" = "workspace::ActivatePaneRight";
              "space w m" = "workspace::CloseAllDocks";

              "space 1" = [
                "workspace::SendKeystrokes"
                "ctrl-1"
              ];
              "space 2" = [
                "workspace::SendKeystrokes"
                "ctrl-2"
              ];
              "space 3" = [
                "workspace::SendKeystrokes"
                "ctrl-3"
              ];
              "space 4" = [
                "workspace::SendKeystrokes"
                "ctrl-4"
              ];
              "space 5" = [
                "workspace::SendKeystrokes"
                "ctrl-5"
              ];
              "space 6" = [
                "workspace::SendKeystrokes"
                "ctrl-6"
              ];
              "space 7" = [
                "workspace::SendKeystrokes"
                "ctrl-7"
              ];
              "space 8" = [
                "workspace::SendKeystrokes"
                "ctrl-8"
              ];
              "space 9" = [
                "workspace::SendKeystrokes"
                "ctrl-9"
              ];

              ", , w" = "vim::HelixJumpToWord";
              ", , s" = "vim::PushSneak";
              ", , S" = "vim::PushSneakBackward";
            }
            // prefixed "space m"
            // prefixed ",";
          }
          {
            context = "ProjectSearchBar > Editor";
            bindings = {
              "escape" = "pane::CloseActiveItem";
            };
          }
          {
            context = "Terminal && screen==normal";
            bindings = {
              "escape" = "workspace::ToggleBottomDock";
            };
          }
          {
            context = "Terminal && screen==alt";
            bindings = {
              "escape" = "pane::CloseActiveItem";
            };
          }
          {
            context = "GitPanel";
            bindings = {
              "tab" = "git::Diff";
              "c c" = "git::Commit";
              "b b" = "git::CheckoutBranch";
              "b c" = "git::Branch";
              "P u" = "git::Push";
              "F u" = "git::Pull";
              "escape" = "workspace::ToggleRightDock";
              "s" = "git::ToggleStaged";
              "S" = "git::StageAll";
              "x" = [
                "workspace::SendKeystrokes"
                "delete"
              ];
            };
          }
          {
            context = "GitDiff > multibuffer";
            bindings = {
              "escape" = "pane::CloseActiveItem";
              "c c" = "git::Commit";
              "x" = "git::Restore";
              "S" = "git::StageAll";
              "s" = "git::ToggleStaged";
            };
          }
          {
            context = "Editor && multibuffer";
            bindings = {
              "escape" = "pane::CloseActiveItem";
              "enter" = "editor::OpenExcerpts";
              "n" = "search::SelectNextMatch";
              "shift-n" = "search::SelectPreviousMatch";
            };
          }
          {
            context = "Editor && mode==auto_height";
            bindings = {
              "ctrl-w ctrl-w" = "workspace::ActivateNextPane";
              "escape" = "workspace::ToggleRightDock";
              "ctrl-c ctrl-c" = "git::Commit";
            };
          }
          {
            context = "AgentPanel > Markdown";
            bindings = {
              "escape" = "workspace::ToggleRightDock";
            };
          }
          {
            context = "EmptyPane";
            bindings = {
              "P u" = "git::Push";
            };
          }
          {
            context = "Welcome || EmptyPane";
            bindings = {
              "space space" = "command_palette::Toggle";
              "space p p" = "projects::OpenRecent";
              "space p t" = "project_panel::ToggleFocus";
              "space p f" = "file_finder::Toggle";
              "space /" = "workspace::NewSearch";
            };
          }
          {
            context = "ProjectPanel && not_editing";
            bindings = {
              "q" = "workspace::ToggleLeftDock";
            };
          }
        ];

        userSettings = {
          vim_mode = true;
          vim = {
            use_system_clipboard = "always";
          };
          # Stand-in for VSpaceCode's which-key menu.
          which_key = {
            enabled = true;
            delay_ms = 300;
          };

          theme = {
            mode = "dark";
            light = "Monochrome Dark";
            dark = "Monochrome Dark";
          };
          buffer_font_family = "Berkeley Mono";
          # VSCode: 14px at window.zoomLevel 1 (x1.2).
          buffer_font_size = 17;

          format_on_save = "on";
          colorize_brackets = false;
          minimap.show = "never";
          inlay_hints.enabled = true;

          file_scan_exclusions = [
            "**/.git"
            "**/.svn"
            "**/.hg"
            "**/.jj"
            "**/.sl"
            "**/.repo"
            "**/CVS"
            "**/.DS_Store"
            "**/Thumbs.db"
            "**/.classpath"
            "**/.settings"
            "**/.bloop"
            "**/.metals"
            "**/.ammonite"
          ];

          edit_predictions.provider = "copilot";

          languages = {
            Nix = {
              tab_size = 2;
              language_servers = [
                "nil"
                "!nixd"
              ];
              formatter.external.command = "nixfmt";
            };
            JSONC.formatter = "prettier";
            Markdown.show_edit_predictions = false;
            "Plain Text".show_edit_predictions = false;
          };

          lsp = {
            basedpyright.settings."basedpyright.analysis".typeCheckingMode = "basic";
          };
        };
      };
    };
  };
}
