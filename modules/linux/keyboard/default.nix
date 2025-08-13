{ user, ... }:
{

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    # xkb.options = "caps:swapescape";
    # kb.variant = "us";
    displayManager = {
      sessionCommands = ''
        export XCOMPOSEFILE = "/home/${user.username}/.XCompose"
      '';
    };
  };

  # Configure console keymap
  # console.keyMap = "sv-latin1";
  console.useXkbConfig = true;

  services.kmonad = {
    enable = true;

    keyboards.anne-pro = {
      device = "/dev/input/by-id/usb-OBINS_HEXCORE_ANNEPRO2_ISO_024319480260704718490428086803D1-event-kbd";
      # "/dev/input/by-id/usb-OBINS_HEXCORE_ANNEPRO2_ISO_024319480260704718490428086803D1-event-if01";

      defcfg = {
        enable = false;
        fallthrough = true;
      };

      config = builtins.readFile ./anne-pro.kbd;
    };
  };
}
