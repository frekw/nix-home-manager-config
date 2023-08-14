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

ocamlPackages = with pkgs; [
  opam
  ocaml-ng.ocamlPackages_5_0.dune_3
  ocaml-ng.ocamlPackages_5_0.ocaml
  ocaml-ng.ocamlPackages.ocaml-lsp
  ocaml-ng.ocamlPackages_5_0.reason

  pkg-config
  libev
];

homePackages = with pkgs; [
  # _1password
  # _1password-gui
  # adr
  altair
  # appLauncher
  bash
  bat
  clang-tools
  cmake
  deno
  elixir
  fd
  ffmpeg
  (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm pkgs.google-cloud-sdk.components.bigtable pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin])
  gopls
  go-outline
  # graalvm19-ce
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
  obsidian
  podman
  podman-compose
  (pkgs.writeShellScriptBin "docker" "exec -a $0 ${podman}/bin/podman $@")
  python3
  reattach-to-user-namespace
  # rectangle
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
  yq-go
  youtube-dl
  # openjdk17
  qemu
  wombat
  zlib
];

in fonts ++ homePackages ++ gitTools ++ nixTools ++ ocamlPackages
