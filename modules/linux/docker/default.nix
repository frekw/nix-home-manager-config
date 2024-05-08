{ user, pkgs, ... }:
{

  virtualisation.docker = {
    enable = true;
  };

  home-manager.users.${user.username} = {
    home.packages = [ pkgs.docker-compose ];
  };
}
