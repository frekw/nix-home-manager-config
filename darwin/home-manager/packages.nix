{ unstable, pkgs }:

let
# pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
altair = pkgs.callPackage ./packages/altair.nix {};
# appLauncher = pkgs.callPackage ./packages/app.nix {};
kubent = pkgs.callPackage ./packages/kubent.nix {};
obsidian = pkgs.callPackage ./packages/obsidian.nix {};
syb-cli = pkgs.callPackage ./packages/syb-cli.nix {};
sloth = pkgs.callPackage ./packages/sloth.nix {};
adr = pkgs.callPackage ./packages/adr.nix {};
vlc = pkgs.callPackage ./packages/vlc.nix {};
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
  git-ps-rs
  spr
  nodePackages_latest.graphite-cli
];

nixTools = with pkgs; [
  cachix
];

ocamlPackages = with pkgs; [
  opam
  ocaml-ng.ocamlPackages_5_0.dune_3
  ocaml-ng.ocamlPackages_5_0.ocaml
  ocaml-ng.ocamlPackages.ocaml-lsp
  ocaml-ng.ocamlPackages_5_0.reason

  pkg-config
  libev
];

jsPackages = with pkgs; [
  bun
  deno
  nodejs_latest
];

k8sPackages = with pkgs; [
  # kubent
  fluxcd
  (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm pkgs.google-cloud-sdk.components.bigtable pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
  krew
  kubectl
  kubectx
  kubernetes-helm
  kustomize
  microplane
  podman
  podman-compose
  (pkgs.writeShellScriptBin "docker" "exec -a $0 ${podman}/bin/podman $@")
  qemu
  sloth
  terraform
];

homePackages = with pkgs; [
  # adr
  altair
  # appLauncher
  bash
  bat
  bazel
  clang-tools
  cmake
  elixir
  fd
  ffmpeg
  gopls
  go-outline
  # graalvm19-ce
  grpcurl
  httpie
  jq
  keybase
  # mkchromecast
  mplayer
  ninja
  nixfmt
  obsidian
  python3
  reattach-to-user-namespace
  rectangle
  ripgrep
  rnix-lsp
  ruby
  scala
  slack
  syb-cli
  # sqlitebrowser
  tree
  yarn
  yq-go
  youtube-dl
  # openjdk17
  vlc
  wombat
  zlib
];

in fonts ++ homePackages ++ gitTools ++ nixTools ++ ocamlPackages ++ jsPackages ++ k8sPackages