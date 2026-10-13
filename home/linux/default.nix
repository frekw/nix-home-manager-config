{
  user,
  pkgs,
  config,
  fonts,
  claude-desktop,
  ...
}:
{
  imports = [
    ../base
    ./audio
    ./fonts.nix
    ./zsh
  ];

  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = "23.11";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # homee.file.".XCompose".text e= ''
  #   include "%L"
  #   <Multi_key> <a> <o> : "å"
  #   <Multi_key> <"> <a> : "ä"
  #   <Multi_key> <"> <o> : "ö"
  # '';

  gtk = {
    enable = true;
    font = {
      package = fonts.packages.${pkgs.stdenv.hostPlatform.system}.berkeley-mono;
      name = "BerkeleyMono-Regular";
    };

    gtk4 = {
      theme = {
        name = "Adwaita Dark";
      };
    };
  };

  home.packages = with pkgs; [
    unstable._1password-cli
    unstable._1password-gui
    docker-compose
    ncspot
    obsidian
    spotify
    pants
    claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
