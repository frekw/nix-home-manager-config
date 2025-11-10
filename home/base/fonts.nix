{ pkgs, fonts, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    corefonts
    vista-fonts
    fira-code
    monaspace
    nerd-fonts.fira-code
    fonts.packages.${pkgs.stdenv.hostPlatform.system}.berkeley-mono
  ];
}
