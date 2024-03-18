{pkgs, user, ...} @ args:
{
  environment.systemPackages = with pkgs; [
    git

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

  users.users.${user.username} = {
    description = user.name;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [user.username];
  };
}