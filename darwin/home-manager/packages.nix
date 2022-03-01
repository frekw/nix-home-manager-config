{ pkgs }:

let
pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
altair = pkgs.callPackage ./altair.nix {};

fonts = with pkgs; [
  fira-code
  (nerdfonts.override { fonts = ["FiraCode"]; })
];

gitTools = with pkgs; [
  delta
  diff-so-fancy
  git-codeowners
];

nixTools = with pkgs; [
  cachix
];

homePackages = with pkgs; [
  _1password
  altair
  bat
  deno
  elixir
  httpie
  jq
  keybase
  kubectl
  kubectx
  nixfmt
  nodejs_latest
  python3
  reattach-to-user-namespace
  rnix-lsp
  ruby
  scala
  slack
  terraform
  yarn
  youtube-dl
  pkgsMaster.openjdk17
];

in fonts ++ homePackages ++ gitTools ++ nixTools
