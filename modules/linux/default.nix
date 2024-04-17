{ pkgs, ... }: {
  imports = [ ../base ./audio.nix ./keyboard ./vpn ./locale.nix ];
}
