{ unstable, pkgs }:

let
# pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
altair = pkgs.callPackage ./packages/altair.nix {};
# appLauncher = pkgs.callPackage ./packages/app.nix {};
kubent = pkgs.callPackage ./packages/kubent.nix {};
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
  (unstable.pkgs.google-cloud-sdk.withExtraComponents [unstable.pkgs.google-cloud-sdk.components.bigtable])
  gopls
  go-outline
  httpie
  jq
  keybase
  kubectl
  kubectx
  # kubent
  krew
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
  # sqlitebrowser
  terraform
  yarn
  youtube-dl
  openjdk17
];

in fonts ++ homePackages ++ gitTools ++ nixTools
