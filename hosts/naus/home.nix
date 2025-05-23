{ pkgs, user, ... }:
{
  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "24.11";
    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = with pkgs; [
      _1password-cli
    ];
  };
}
