{ pkgs, fonts, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    corefonts
    vistafonts
    fira-code
    monaspace
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fonts.packages.${pkgs.system}.berkeley-mono
  ];
}
