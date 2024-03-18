{ pkgs, lib, user, ... }@args: {
  environment.systemPackages = with pkgs; [
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
    ipcalc

    # misc
    which
    tree
  ];

  users.users.${user.username} = { description = user.name; };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ user.username ];

    # Manual optimise storage: nix-store --optimise
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}
