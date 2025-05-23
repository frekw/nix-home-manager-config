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
    github = {
      enable = lib.mkEnableOption "github";
    };
  };

  config = lib.mkIf config.modules.dev.github.enable {
    modules.programs.zsh.enable = true;

    home-manager.users.${user.username} = {
      imports = [
        agenix.homeManagerModules.default
      ];

      age.secrets.github-token.file = ../../../secrets/github-token.age;

      programs.gh = {
        enable = true;
      };

      programs.zsh = {
        initContent = ''
          export GITHUB_TOKEN=$(${pkgs.coreutils}/bin/cat ${
            config.home-manager.users.${user.username}.age.secrets.github-token.path
          })
        '';
      };
    };
  };
}
