{ pkgs, fonts, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    corefonts
    vistafonts
    fira-code
    monaspace
    nerd-fonts.fira-code
    fonts.packages.${pkgs.system}.berkeley-mono
  ];
}
