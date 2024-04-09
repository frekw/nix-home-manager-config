{ ... }: {

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.options = "caps:swapescape";
    xkb.variant = "us";
  };

  # Configure console keymap
  # console.keyMap = "sv-latin1";
  console.useXkbConfig = true;
}
