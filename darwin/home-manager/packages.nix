{ unstable, pkgs }:

let
pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
pkgsTF136 = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/39ed4b64ba5929e8e9221d06b719a758915e619b.tar.gz") {};
altair = pkgs.callPackage ./packages/altair.nix {};
# appLauncher = pkgs.callPackage ./packages/app.nix {};
kubent = pkgs.callPackage ./packages/kubent.nix {};
monaspace = pkgs.callPackage ./packages/monaspace.nix {};
obsidian = pkgs.callPackage ./packages/obsidian.nix {};
syb-cli = pkgs.callPackage ./packages/syb-cli.nix {};
sloth = pkgs.callPackage ./packages/sloth.nix {};
adr = pkgs.callPackage ./packages/adr.nix {};
vlc = pkgs.callPackage ./packages/vlc.nix {};
wombat = pkgs.callPackage ./packages/wombat.nix {};
tunnelblick = pkgs.callPackage ./packages/tunnelblick.nix {};
pants-scie = pkgs.callPackage ./packages/pants.nix {};


fonts = with pkgs; [
  fira-code
  monaspace
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
  gitmux
  spr
  unstable.nodePackages_latest.graphite-cli
  pkgsMaster.sapling
];

nixTools = with pkgs; [
  cachix
];

ocamlPackages = with pkgs; [
  # pkgsMaster.opam
  pkg-config
  libev
  # ocaml-ng.ocamlPackages_5_0.dune_3
  # ocaml-ng.ocamlPackages_5_0.ocaml
  # ocaml-ng.ocamlPackages.ocaml-lsp
  # ocaml-ng.ocamlPackages_5_0.reason
  # WASM
  # binaryen
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
  (pkgs.writeShellScriptBin "docker-compose" "exec -a $0 ${podman-compose}/bin/podman-compose $@")
  qemu
  rancher
  sloth
  sops
  pkgsTF136.terraform
];

buildTools = with pkgs; [
  bazel
  buck2
  cmake
  pants-scie
  ninja
];

homePackages = with pkgs; [
  # adr
  audacity
  altair
  # appLauncher
  bash
  bat
  clang-tools
  elixir
  fd
  ffmpeg
  gopls
  go-outline
  ginkgo
  # graalvm19-ce
  graphviz
  grpcurl
  httpie
  jq
  keybase
  # mkchromecast
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
  # tunnelblick
  yarn
  yq-go
  youtube-dl
  # openjdk17
  vlc
  wombat
  zlib
];

in fonts ++ homePackages ++ gitTools ++ nixTools ++ buildTools ++ ocamlPackages ++ jsPackages ++ k8sPackages