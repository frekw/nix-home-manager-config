{ pkgs, ... }: {
  imports = [ ../base ./audio.nix ./keyboard.nix ./locale.nix ];
}
