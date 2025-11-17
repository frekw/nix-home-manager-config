{
  agenix,
  pkgs,
  config,
  lib,
  user,
  ...
}:
{
  options.modules.dev = {
    zed = {
      enable = lib.mkEnableOption "zed";
    };
  };

  config = lib.mkIf config.modules.dev.zed.enable {
    # modules.programs.zsh.enable = true;

    # Base16 Grayscale Dark

    home-manager.users.${user.username} = {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "elixir"
          "graphql"
          "helm"
          "java"
          "ocaml"
          "scala"
          "sql"
          "terraform"
          "typos"

          # themes
          "base16"
          "brook-code-theme"
          "evil-rabbit-theme"
          "gruber-darker"
          "hacker-night-vision"
          "hacker-theme"
        ];
        # Keybindings from https://github.com/wangfenjin/zed/blob/main/keymap.json
        userKeymaps = [
          {
            context = "VimControl && !menu";
            bindings = {
              "space f e d" = "zed::OpenKeymap";
              "space w m" = "workspace::CloseAllDocks";
              "space f y y" = "workspace::CopyPath";
              "space '" = "terminal_panel::ToggleFocus";
              "space g s" = "git_panel::ToggleFocus";
              "space g b" = "git::Blame";
              "space g l l" = "editor::OpenPermalinkToLine";
              "space b b" = "file_finder::Toggle";
              "space b d" = "pane::CloseActiveItem";
              "space b s" = "workspace::NewFile";
              "space tab" = "pane::AlternateFile";
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
              "space c l" = "vim::ToggleComments";
              "space j i" = "outline::Toggle";
              "space p p" = "projects::OpenRecent";
              "space p t" = "project_panel::ToggleFocus";
              "space p f" = "file_finder::Toggle";
              "space /" = "workspace::NewSearch";
              "space *" = [
                "workspace::SendKeystrokes"
                "cmd-d space / enter"
              ];
              "ctrl-w ctrl-w" = "agent::ToggleFocus";
              "space a i" = "agent::ToggleFocus";
            };
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
            use_key_equivalents = true;
            bindings = {
              "cmd-shift-c" = null;
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
              "x" = [
                "workspace::SendKeystrokes"
                "cmd-alt-z"
              ];
              "S" = "git::StageAll";
              "s" = [
                "workspace::SendKeystrokes"
                "cmd-alt-y"
              ];
            };
          }
          {
            context = "Editor && multibuffer";
            bindings = {
              "escape" = "pane::CloseActiveItem";
              "enter" = [
                "workspace::SendKeystrokes"
                "g space"
              ];
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
            context = "Welcome";
            bindings = {
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
          theme = {
            mode = "dark";
            light = "Evil Rabbit (Dark)";
            dark = "Evil Rabbit (Dark)";
          };
          buffer_font_family = "Berkeley Mono";
          buffer_font_size = 16;
        };
      };
    };
  };
}
