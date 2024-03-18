{pkgs, config, ...}: {
  programs.zsh = {
    defaultKeymap = "viins";
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
      current-commit = "git log -1 --pretty=format:'%h' | tr -d '\n' | pbcopy";
      lock = "pmset displaysleepnow";
      "nix-sha256" = "nix-hash --to-base32 --type sha256";
    };
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = false;
    history = {
      save = 50000;
      size = 50000;
      share = true;
    };
    initExtra = builtins.concatStringsSep "\n" [
          # ''. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"'' 
          (builtins.readFile ./scripts/init.sh)
          (builtins.readFile ./scripts/kube-context-switch.sh)
          (builtins.readFile ./scripts/app-launcher.sh)
          ''
          export JAVA_HOME="${config.home.sessionVariables.JAVA_HOME}"
          setopt PROMPT_SUBST
          export PROMPT='%F{white}%2~ %(?.%F{green}.%F{red})→%f '
          export RPROMPT=
          ''
        ];

    profileExtra = ''
      idconvert() {
        syb -env production idconvert $1
      }
    '';

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
  };
}