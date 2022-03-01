{ pkgs }:

{
  enable = true;
  shellAliases = {
    ".." = "cd ..";
    grep = "grep --color=auto";
    kc = "kubectl";
    diff = "diff --color=auto";
    szsh = "source ~/.zshrc";
    cat = "bat";
    switch = "home-manager switch && source ~/.zshrc";
    garbage = "nix-collect-garbage";
    reload = "switch && garbage";
  };
  enableAutosuggestions = true;
  enableCompletion = true;
  autocd = false;
  history = {
    save = 50000;
    size = 50000;
    share = true;
  };
  initExtra = (builtins.readFile ./init.sh);
  plugins = [
    {
      name = "zsh-autosuggestions";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "v0.6.4";
        sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
      };
    }
    {
      name = "wting";
      src = pkgs.fetchFromGitHub {
        owner = "wting";
        repo = "autojump";
        rev = "release-v22.5.3";
        sha256 = "1rgpsh70manr2dydna9da4x7p8ahii7dgdgwir5fka340n1wrcws";
      };
    }
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
}