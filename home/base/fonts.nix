{pkgs, ...}: {
  packages = with pkgs; [
    fira-code
    monaspace
    (nerdfonts.override { fonts = ["FiraCode"]; })
  ];
}
