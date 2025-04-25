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
    modules.programs.zsh.enable = true;

    home-manager.users.${user.username} = {
      imports = [
        agenix.homeManagerModules.default
      ];

      age.secrets."cf-tf/api-key".file = ../../../secrets/cf-tf/api-key.age;
      age.secrets."cf-tf/backend-config".file = ../../../secrets/cf-tf/backend-config.age;
      age.secrets."cf-tf/zone-id".file = ../../../secrets/cf-tf/zone-id.age;

      programs.zsh = {
        initContent = ''
          export MELON_DANCE_CONFIG_PATH="${
            config.home-manager.users.${user.username}.age.secrets."cf-tf/backend-config".path
          }"
          export TF_VAR_melon_dance_api_token=$(${pkgs.coreutils}/bin/cat ${
            config.home-manager.users.${user.username}.age.secrets."cf-tf/api-key".path
          })
          export TF_VAR_melon_dance_zone_id=$(${pkgs.coreutils}/bin/cat ${
            config.home-manager.users.${user.username}.age.secrets."cf-tf/zone-id".path
          })
        '';
      };
    };
  };
}
