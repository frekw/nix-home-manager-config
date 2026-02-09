{
  lib,
  config,
  pkgs,
  user,
  ...
}:

{
  options.modules.programs = {
    ghostty = {
      enable = lib.mkEnableOption "ghostty";
    };
  };

  config = lib.mkIf config.modules.programs.ghostty.enable {
    home-manager.users.${user.username} = {
      xdg.configFile = {
        "ghostty/launch.sh" = {
          source = ./launch.sh;
        };
      };

      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        enableZshIntegration = true;
        installVimSyntax = true;
        settings = {
          command = "~/.config/ghostty/launch.sh";
          font-family = "Berkeley Mono";
          theme = "Adventure";
          fullscreen = false;
          window-padding-x = 16;
          window-padding-y = 16;
          window-padding-balance = true;
          window-decoration = false;
          auto-update = "off";
        };
      };
    };
  };
}
