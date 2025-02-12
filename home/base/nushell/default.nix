{ pkgs, config, ... }:
{

  age.secrets.github-token.file = ../../../secrets/github-token.age;

  programs.nushell = {
    enable = true;
  };
}
