{ ... }: {
  programs.zsh = {
    shellAliases = {
      switch =
        "sudo nixos-rebuild switch --flake ~/src/priv/nix-home-manager-config";
    };
  };
}
