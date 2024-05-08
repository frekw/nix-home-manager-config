{
  user,
  pkgs,
  mypkgs,
  config,
  fonts,
  ...
}:
{
  imports = [
    ../base
    ./audio
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
      package = fonts.packages.${pkgs.system}.berkeley-mono;
      name = "BerkeleyMono-Regular";
    };

    theme = {
      name = "Adwaita Dark";
    };
  };

  home.packages = with pkgs; [
    _1password
    _1password-gui
    docker-compose
    ncspot
    obsidian
    spotify
    mypkgs.pants
  ];
}
