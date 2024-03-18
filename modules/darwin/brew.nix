{ ... }: {
  homebrew = {
    casks = [ "slack" ];

    brews = [
      # https://github.com/rgcr/m-cli
      "m-cli"

      # commands like `gsed` `gtar` are required by some tools
      "gnu-sed"
      "gnu-tar"
    ];
  };
}
