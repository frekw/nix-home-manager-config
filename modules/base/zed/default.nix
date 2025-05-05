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
        userKeymaps = [
          {
            context = "vim_mode = normal";
            "bindings" = {
              "space f" = "file_finder::Toggle";
              "space p f" = "file_finder::Toggle";
              "space p p" = "projects::OpenRecent";
              "space o" = "workspace::Open";
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
