{ pkgs, fonts, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [ fonts.packages.${pkgs.stdenv.hostPlatform.system}.apple-fonts ];
}
