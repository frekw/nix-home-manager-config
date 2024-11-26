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
    ./hyprland
    ./keyboard
    ./steam
    ./vpn
    ./wayland
    ./locale.nix
  ];
}
