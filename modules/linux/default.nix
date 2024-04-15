{ pkgs, ... }: {
  imports = [ ../base ./audio.nix ./keyboard.nix ./vpn ./locale.nix ];
}
