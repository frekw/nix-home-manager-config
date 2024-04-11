{ pkgs, fonts, ... }: {
  home.packages = with pkgs; [
    corefonts
    vistafonts
    fira-code
    monaspace
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fonts.packages.${pkgs.system}.berkeley-mono
    fonts.packages.${pkgs.system}.apple-fonts
  ];
}
