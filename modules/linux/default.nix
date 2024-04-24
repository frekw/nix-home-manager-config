{ pkgs, ... }: {
  imports = [ ../base ./audio.nix ./keyboard ./hyprland ./vpn ./locale.nix ];
}
