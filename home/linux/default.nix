{ user, pkgs, config, ... }: {
  imports = [ ../base ./audio ./zsh ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "23.11";
    sessionVariables = { EDITOR = "nvim"; };
  };

  home.packages = with pkgs; [ _1password-gui _1password spotify ];
}
