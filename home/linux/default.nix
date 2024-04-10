{ user, pkgs, config, ... }: {
  imports = [ ../base ./zsh ];

  age.secrets.github-token.file = ../../secrets/github-token.age;

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
      GITHUB_TOKEN = ''
        $(${pkgs.coreutils}/bin/cat ${config.age.secrets.github-token.path})
      '';
    };
  };

  home.packages = with pkgs; [ _1password-gui _1password spotify ];
}
