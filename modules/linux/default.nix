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
    ./vpn
    ./locale.nix
  ];
}
