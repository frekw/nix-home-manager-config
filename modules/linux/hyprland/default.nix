{ lib, config, pkgs, user, ... }:
let
  enableHyprland = config.modules.desktop.hyprland;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";
  mkIfElse = p: yes: no: lib.mkMerge [ (lib.mkIf p yes) (lib.mkIf (!p) no) ];
in {

  options.modules.desktop = {
    hyprland = { enable = lib.mkEnableOption "Hyprland"; };
  };

	imports = [./home.nix];

  config = (lib.mkIf enableHyprland.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl
      playerctl
      xdg-utils
    ];

    security.pam.services.swaylock = { };
    security.pam.services.swaylock.fprintAuth = false;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    };

    services.xserver.enable = false;
    programs.hyprland.enable = true;

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = user.username;
        };
        default_session = initial_session;
      };
    };

    # this is a life saver.
    # literally no documentation about this anywhere.
    # might be good to write about this...
    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  });
}
