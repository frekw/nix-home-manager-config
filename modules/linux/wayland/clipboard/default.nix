{
  pkgs,
  lib,
  config,
  user,
  ...
}:
{
  options.modules.desktop.wayland = {
    clipboard = {
      enable = lib.mkEnableOption "wl-clipboard";
    };
  };
  config = (
    lib.mkIf config.modules.desktop.wayland.clipboard.enable {
      home-manager.users.${user.username} = {
        home.packages = [ pkgs.wl-clipboard ];
        programs.zsh.shellAliases = {
          pbcopy = "wl-copy";
          pbpaste = "wl-paste";
        };
      };
    }
  );
}
