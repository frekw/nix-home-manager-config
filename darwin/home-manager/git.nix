{ pkgs }:

let
  pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
in
{
  enable = true;
  package = pkgsMaster.gitAndTools.gitFull;
  userName = "frekw";
  userEmail = "fredrik@warnsberg.se";
  ignores = [
   ".cache/"
    ".DS_Store"
    ".idea/"
    "*.swp"
    "dumb.rdb"
    ".elixir_ls/"
    ".vscode/"
    "npm-debug.log"
  ];
  aliases = {
    ci = "commit";
    cm = "commit -m";
    s = "status";
    pr = "pull --rebase";
    st = "status";
    l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";

    # Change to default branch (main/master/???)
    main = "!git switch $(basename $(git symbolic-ref --short refs/remotes/origin/HEAD))";

    # From https://adamj.eu/tech/2022/10/30/git-how-to-clean-up-squash-merged-branches/
    rm-gone-from-remote = "!git branch --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" { print $1 }' | xargs -r git branch -D";

    # Update from remote and delete all branches removed from remote
    sync = "!git main && git pull --prune && git rm-gone-from-remote";
  };

  signing = {
    key = "456E7B9AD00B512DFF44ACC5F7CA7570539B75D1";
    signByDefault = true;
  };

  extraConfig = {
    core = {
      editor = "nvim";
      whitespace = "trailing-space,space-before-tab";
    };

    url = {
      "git@github.com:" = { insteadOf = https://github.com/; };
    };

    commit.gpgsign = "true";
    # gpg.program = "gpg2";
    credential.helper = "osxkeychain";
    pull.rebase = "true";
    init.defaultBranch = "main";
    push.autoSetupRemote = "true";
  };
}