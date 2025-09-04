{ pkgs, ... }:
{
  # needed for pants
  programs.nix-ld.enable = true;

  imports = [
    ../base
    ./audio.nix
    ./docker
    ./dropbox
    # ./keyboard
    ./locale.nix
    ./minecraft
    ./vpn
  ];
}
