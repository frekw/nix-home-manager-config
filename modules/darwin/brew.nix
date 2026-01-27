{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    masApps = {
      # this is 1password 7 currently.
      # "1Password" = 1333542190;
      "iA Writer" = 775737590;
      "Pixelmator Classic" = 407963104;
      "Poolsuite FM" = 1514817810;
      "Soundtrack Player" = 1114799709;
      "XCode" = 497799835;
    };

    casks = [
      "1password"
      "altair-graphql-client"
      "balenaetcher"
      "dropbox"
      "figma"
      "heynote"
      "logitune"
      "loom"
      "shureplus-motiv"
      "slack"
      "spotify"
      "tunnelblick"
      "multi-gitter"
    ];

    brews = [
      # https://github.com/rgcr/m-cli
      "m-cli"

      # commands like `gsed` `gtar` are required by some tools
      "gnu-sed"
      "gnu-tar"
    ];
  };
}
