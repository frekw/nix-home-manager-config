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
        ];
        # userKeymaps = { };
        userSettings = { };
      };
    };
  };
}
