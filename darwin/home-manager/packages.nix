{ unstable, pkgs }:

let
# pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
altair = pkgs.callPackage ./packages/altair.nix {};
# appLauncher = pkgs.callPackage ./packages/app.nix {};
kubent = pkgs.callPackage ./packages/kubent.nix {};
syb-cli = pkgs.callPackage ./packages/syb-cli.nix {};
adr = pkgs.callPackage ./packages/adr.nix {};

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
  adr
  altair
  # appLauncher
  bash
  bat
  deno
  elixir
  fd
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
  # mkchromecast
  nixfmt
  nodejs_latest
  podman
  podman-compose
  (pkgs.writeShellScriptBin "docker" "exec -a $0 ${podman}/bin/podman $@")
  python3
  reattach-to-user-namespace
  ripgrep
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
  qemu
];

in fonts ++ homePackages ++ gitTools ++ nixTools
