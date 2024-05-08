{ pkgs, ... }:
{
  imports = [
    ../base
    ./audio.nix
    ./docker
    ./dropbox
    ./keyboard
    ./hyprland
    ./vpn
    ./locale.nix
  ];
}
