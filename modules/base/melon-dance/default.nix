{
  agenix,
  pkgs,
  config,
  lib,
  user,
  ...
}:
{
  options.modules.dev = {
    melon-dance = {
      enable = lib.mkEnableOption "melon-dance";
    };
  };

  config = lib.mkIf config.modules.dev.melon-dance.enable {
    home-manager.users.${user.username} = {
      imports = [
        agenix.homeManagerModules.default
      ];

      age.secrets."cf-tf/api-key".file = ../../../secrets/cf-tf/api-key.age;
      age.secrets."cf-tf/backend-config".file = ../../../secrets/cf-tf/backend-config.age;

      programs.gh = {
        enable = true;
      };

      programs.zsh = {
        initExtra = ''
          export MELON_DANCE_CONFIG_PATH="${
            config.home-manager.users.${user.username}.age.secrets."cf-tf/backend-config".path
          }"
          export TF_VAR_MELON_DANCE_API_TOKEN=$(${pkgs.coreutils}/bin/cat ${
            config.home-manager.users.${user.username}.age.secrets."cf-tf/api-key".path
          })
        '';
      };
    };
  };
}
