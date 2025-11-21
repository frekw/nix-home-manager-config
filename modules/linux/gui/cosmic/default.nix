{
  lib,
  config,
  pkgs,
  user,
  ...
}:

{
  options.modules.desktop = {
    cosmic = {
      enable = lib.mkEnableOption "Cosmic desktop";
    };
  };
  config = (
    lib.mkIf config.modules.desktop.cosmic.enable {
      modules.desktop.wayland.clipboard.enable = true;

      home-manager.users.${user.username} = {
        home = {
          sessionVariables = {
            NIXOS_OZONE_WL = "1";
            MOZ_ENABLE_WAYLAND = "1";
          };
        };
      };

      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;
      services.desktopManager.cosmic.xwayland.enable = true;

      # disable screen reader
      services.orca.enable = false;
    }
  );
}
