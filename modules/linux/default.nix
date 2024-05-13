{ pkgs, ... }:
{
  # needed for pants
  programs.nix-ld.enable = true;

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
