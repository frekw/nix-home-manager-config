{ user, pkgs, config, ... }: {
  imports = [ ../base ./zsh ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };
  };

  home.packages = with pkgs; [ _1password-gui _1password spotify ];
}
