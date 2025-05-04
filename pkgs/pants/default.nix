{
  pkgs,
  lib,
  stdenv,
  fetchurl,
  fetchFromGitHub,
  rustPlatform,
  writeShellScriptBin,
  nix-alien,
  ...
}:
let
  version = "0.12.3";
  if_let = v: p: if lib.attrsets.matchAttrs p v then v else null;
  match =
    v: l: builtins.elemAt (lib.lists.findFirst (x: (if_let v (builtins.elemAt x 0)) != null) null l) 1;
  package = match { platform = stdenv.system; } [
    [
      { platform = "aarch64-linux"; }
      {
        url = "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-linux-aarch64";
        sha256 = lib.emptyShaHash;
      }
    ]
    [
      { platform = "x86_64-linux"; }
      {
        url = "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-linux-x86_64";
        sha256 = "sha256-ifP5gjTdLMXyVSKda6pPBNNcnJZ0giuqikFBk7cXgHI=";
      }
    ]
    [
      { platform = "aarch64-darwin"; }
      {
        url = "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-macos-aarch64";
        sha256 = lib.emptyShaHash;
      }
    ]
  ];
  unpatched = stdenv.mkDerivation {
    name = "scie-pants";
    version = version;
    sourceRoot = ".";
    phases = [
      "installPhase"
      "patchPhase"
    ];

    src = fetchurl package;
    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp $src $out/bin/pants
      chmod +x $out/bin/pants

      runHook postInstall
    '';
  };
  patched = writeShellScriptBin "pants" ''
    export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    ${nix-alien.packages."${pkgs.system}".default}/bin/nix-alien ${unpatched}/bin/pants -- "$@"
  '';
in
if stdenv.isDarwin then unpatched else patched
