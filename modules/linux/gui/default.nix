{ pkgs, ... }:
{
  # needed for pants
  programs.nix-ld.enable = true;

  imports = [
    ./cosmic
    ./hyprland
    ./wayland
    ./steam
  ];
}
