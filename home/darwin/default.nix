{ pkgs, user, mypkgs, ... }: {
  imports = [ ../base ./zsh ./docker.nix ];

  home = {
    username = user.username;
    homeDirectory = "/Users/${user.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };
  };

  home.packages = with pkgs; [
    mypkgs.darwin.altair
    mypkgs.darwin.obsidian
    mypkgs.darwin.vlc
    mypkgs.darwin.wombat
    reattach-to-user-namespace
    rectangle
  ];
}
