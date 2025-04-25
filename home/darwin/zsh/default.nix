{ pkgs, ... }:
{
  programs.zsh = {
    shellAliases = {
      switch = "darwin-rebuild switch --flake ~/src/priv/nix-home-manager-config";
    };
    initContent = ''
      eval $(brew shellenv)
    '';
    plugins = [
      {
        name = "macos";
        src = pkgs.fetchFromGitHub {
          owner = "joow";
          repo = "macos";
          rev = "76bb298dc0ff5c5a1c640fe8f33f09c68b9af239";
          sha256 = "13mq0dq2y7d4m5cxxj13mbplk53kgg3j3f2id89klaw28kh9jrvs";
        };
      }
    ];
  };
}
