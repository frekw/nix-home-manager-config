{ lib, config, pkgs, ... }:
let enableHyprland = config.modules.desktop.hyprland;
in {

  options.modules.desktop = {
    hyprland = { enable = lib.mkEnableOption "Hyprland"; };
  };

  config = (lib.mkIf enableHyprland.enable {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    };

    services = { xserver.enable = false; };
    programs.hyprland.enable = true;
  });
}
