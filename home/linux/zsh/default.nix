{ config, ... }:
{
  programs.zsh = {
    shellAliases = {
      build = "cd ~/src/priv/nix-home-manager-config && nix flake check && cd -";
      switch = "nixos-rebuild switch --flake ~/src/priv/nix-home-manager-config --sudo";
    };

    dotDir = "${config.xdg.configHome}/zsh";
  };
}
