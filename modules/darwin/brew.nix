{ ... }: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    masApps = {
      # 1password
      # iA writer
      # pixelmator
      # Xcode = 497799835;
    };

    casks = [ "slack" "logitune" "loom" "tunnelblick" "dropbox" "figma" ];

    brews = [
      # https://github.com/rgcr/m-cli
      "m-cli"

      # commands like `gsed` `gtar` are required by some tools
      "gnu-sed"
      "gnu-tar"
    ];
  };
}
