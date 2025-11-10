{
  pkgs,
  lib,
  user,
  agenix,
  ...
}@args:
{
  imports = [
    ./ghostty
    ./github
    ./melon-dance
    ./work
    ./zed
    ./zsh
  ];

  environment.systemPackages = with pkgs; [
    agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
    backblaze-b2

    colmena

    git
    neovim

    # archives
    zip
    xz
    zstd
    unzip
    p7zip
    gnutar

    # Text Processing
    # Docs: https://github.com/learnbyexample/Command-line-text-processing
    gnugrep # GNU grep, provides `grep`/`egrep`/`fgrep`
    gnused # GNU sed, very powerful(mainly for replacing text in files)
    gawk # GNU awk, a pattern scanning and processing language
    jq # A lightweight and flexible command-line JSON processor
    yq

    # networking
    wget
    curl

    # misc
    which
    tree
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ user.username ];
  };

  nix.optimise = {
    # Manual optimise storage: nix-store --optimise
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    automatic = true;
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}
