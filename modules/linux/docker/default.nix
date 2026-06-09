{ user, pkgs, ... }:
{

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker;
  };

  home-manager.users.${user.username} = {
    home.packages = [ pkgs.docker-compose ];
  };
}
