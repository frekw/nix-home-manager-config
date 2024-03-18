{config, user, ...}: {
  xdg.configFile = {
    "git-ps" = {
      source = ./config;
      recursive = true;
    };
  };
}