{
  pkgs,
  config,
  lib,
  user,
  ...
}:
{
  options.modules.dev = {
    github = {
      enable = lib.mkEnableOption "github";
    };
  };

  config = lib.mkIf config.modules.dev.github.enable {
    modules.programs.age.enable = true;
    modules.programs.zsh.enable = true;

    home-manager.users.${user.username} = {
      age.secrets.github-token.file = ../../../secrets/github-token.age;

      programs.gh = {
        enable = true;
      };

      programs.zsh = {
        initExtra = ''
          export GITHUB_TOKEN=$(${pkgs.coreutils}/bin/cat ${
            config.home-manager.users.${user.username}.age.secrets.github-token.path
          })
        '';
      };
    };
  };
}
