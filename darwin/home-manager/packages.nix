{ pkgs }:

let
pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
altair = pkgs.callPackage ./packages/altair.nix {};
# appLauncher = pkgs.callPackage ./packages/app.nix {};
syb-cli = pkgs.callPackage ./packages/syb-cli.nix {};

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
  # appLauncher
  bash
  bat
  deno
  elixir
  google-cloud-sdk
  httpie
  jq
  keybase
  kubectl
  kubectx
  nixfmt
  nodejs_latest
  podman
  podman-compose
  python3
  reattach-to-user-namespace
  rnix-lsp
  ruby
  scala
  slack
  syb-cli
  terraform
  yarn
  youtube-dl
  pkgsMaster.openjdk17
];

in fonts ++ homePackages ++ gitTools ++ nixTools
