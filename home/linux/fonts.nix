{ pkgs, fonts, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [ fonts.packages.${pkgs.system}.apple-fonts ];
}
