{config, ...}: {
  home.file = {
    "${config.xdg.configHome}/git-ps" = {
      source = ./config;
      recursive = true;
    };
  };
}