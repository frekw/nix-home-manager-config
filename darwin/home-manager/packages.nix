{ unstable, pkgs }:

let
# pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
altair = pkgs.callPackage ./packages/altair.nix {};
# appLauncher = pkgs.callPackage ./packages/app.nix {};
kubent = pkgs.callPackage ./packages/kubent.nix {};
syb-cli = pkgs.callPackage ./packages/syb-cli.nix {};
sloth = pkgs.callPackage ./packages/sloth.nix {};
adr = pkgs.callPackage ./packages/adr.nix {};
wombat = pkgs.callPackage ./packages/wombat.nix {};

fonts = with pkgs; [
  fira-code
  (nerdfonts.override { fonts = ["FiraCode"]; })
];

gitTools = with pkgs; [
  delta
  diff-so-fancy
  git-absorb
  git-branchless
  git-codeowners
  git-open
  spr
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
  clang-tools
  cmake
  deno
  elixir
  fd
  (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm pkgs.google-cloud-sdk.components.bigtable])
  gopls
  go-outline
  grpcurl
  httpie
  jetbrains.idea-community
  jq
  keybase
  kubectl
  kubectx
  kubernetes-helm
  kustomize
  # kubent
  krew
  # mkchromecast
  mplayer
  ninja
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
  sloth
  syb-cli
  # sqlitebrowser
  terraform
  tree
  yarn
  youtube-dl
  openjdk17
  qemu
  wombat
  zlib
];

in fonts ++ homePackages ++ gitTools ++ nixTools
