{ config, ... }: {
  xdg.configFile = { "wireplumber" = { source = ./wireplumber; }; };
}
