{ ... }:
{
  programs.zsh = {
    shellAliases = {
      build = "cd ~/src/priv/nix-home-manager-config && nix flake check && cd -";
      switch = "sudo nixos-rebuild switch --flake ~/src/priv/nix-home-manager-config";
    };
  };
}
