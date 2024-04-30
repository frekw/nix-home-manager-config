{ lib, stdenv, fetchurl }:
let
  version = "0.11.0";
  if_let = v: p: if lib.attrsets.matchAttrs p v then v else null;
  match = v: l:
    builtins.elemAt
    (lib.lists.findFirst (x: (if_let v (builtins.elemAt x 0)) != null) null l)
    1;
  package = match { platform = stdenv.system; } [
    [
      { platform = "aarch64-linux"; }
      {
        url =
          "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-linux-aarch64";
        sha256 = lib.emptyShaHash;
      }
    ]
    [
      { platform = "x86_64-linux"; }
      {
        url =
          "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-linux-x86_64";
        sha256 = "sha256-ifP5gjTdLMXyVSKda6pPBNNcnJZ0giuqikFBk7cXgHI=";
      }
    ]
    [
      { platform = "aarch64-darwin"; }
      {
        url =
          "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-macos-aarch64";
        sha256 = lib.emptyShaHash;
      }
    ]
  ];

in stdenv.mkDerivation {
  name = "scie-pants";
  version = version;
  sourceRoot = ".";
  phases = [ "installPhase" "patchPhase" ];

  src = fetchurl package;
  # fetchurl {
  #   url =
  #     "https://github.com/pantsbuild/scie-pants/releases/download/v${version}/scie-pants-macos-aarch64";
  #   sha256 = "5e847e91ad908eeb41b4fadb92c0b8c05938991c350d4940d25ce23b1f2ce97e";
  # };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/pants
    chmod +x $out/bin/pants
  '';
}

# rustPlatform.buildRustPackage rec {
#   pname = "pantsbuild.pants";
#   version = "0.11.0";

#   src = fetchFromGitHub {
#     owner = "pantsbuild";
#     repo = "scie-pants";
#     rev = "v${version}";
#     hash = "sha256-UwhASnhBi4HjP1qiXJ0tjnQEOLmfBk2oOYNzDHLRKk4=";
#   };

#   cargoHash = "sha256-vvujhBfd2HbpS6RFtEXZEIgvB1NeVlpZZY1Hodn0AH0=";

#   # cargo run -p package -- --dest-dir dist/ scie
#   buildPhase = ''
#     # mkdir $out/dist
#     export SCIE_PANTS_DEV_CACHE=$out/.cache
#     cargo run -p package -- --dest-dir $out/dist/ tools
#     cargo run -p package -- --dest-dir $out/dist/ scie-pants
#     cargo run -p package -- --dest-dir $out/dist/ scie \
#       --scie-pants $out/dist/scie-pants --tools-pex $out/dist/tools.pex
#   '';

#   postInstall = ''
#     ls -lah
#     echo $out
#     ls $out
#     cp $out/bin/scie $out/bin/pants
#   '';

#   meta = with lib; {
#     description =
#       "A build system for software projects in a variety of languages";
#     homepage = "https://www.pantsbuild.org/";
#     license = licenses.asl20;
#     maintainers = [ maintainers.frekw ];
#   };
# }
