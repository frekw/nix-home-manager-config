{ pkgs, ... }: {
  imports =
    [ ../base ./audio.nix ./dropbox ./keyboard ./hyprland ./vpn ./locale.nix ];
}
