{ pkgs, ... }:
{
  # needed for pants
  programs.nix-ld.enable = true;

  imports = [
    ../base
    ./audio.nix
    ./cosmic
    ./docker
    ./dropbox
    ./keyboard
    ./hyprland
    ./vpn
    ./wayland
    ./locale.nix
  ];
}
