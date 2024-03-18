{user, mypkgs, ...}: {
  imports = [
    ../base
    ./docker.nix
  ];

  home = {
    username = user.username;
    homeDirectory = "/Users/${user.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };
  };

  home.packages = [
    mypkgs.darwin.altair
    mypkgs.darwin.obsidian
    mypkgs.darwin.vlc
    mypkgs.darwin.wombat
  ];
}