{
  pkgs,
  user,
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
    app-launcher
    # mypkgs.darwin.altair
    darwinPackages.obsidian
    darwinPackages.vlc
    darwinPackages.wombat
    rectangle
  ];
}
