{
  pkgs,
  user,
  mypkgs,
  config,
  ...
}:
{
  imports = [
    ../base
    ./zsh
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

  home.packages = with pkgs; [
    mypkgs.app-launcher
    # mypkgs.darwin.altair
    mypkgs.darwin.obsidian
    mypkgs.darwin.vlc
    mypkgs.darwin.wombat
    reattach-to-user-namespace
    rectangle
  ];
}
