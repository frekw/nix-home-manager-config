{
  pkgs,
  lib,
  config,
  agenix,
  user,
  ...
}:
{
  options.modules.env = {
    work = {
      enable = lib.mkEnableOption "age";
    };
  };

  config = lib.mkIf config.modules.env.work.enable {
    home-manager.users.${user.username} = {
      imports = [
        agenix.homeManagerModules.default
      ];

      config.age = {
        secrets.terraformrc = {
          file = ../../../secrets/terraformrc.age;
          path = "\${HOME}/.terraformrc";
          symlink = false;
        };

        secrets.npmrc = {
          file = ../../../secrets/npmrc.age;
          path = "\${HOME}/.npmrc";
          symlink = false;
        };
      };
    };
  };
}
