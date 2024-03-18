{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "wombat";
  version = "0.5.0";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r Wombat.app "$out/Applications/Wombat.app"
  '';

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url =
      "https://github.com/rogchap/wombat/releases/download/v0.5.0/Wombat_v0.5.0_Darwin_x86_64.dmg";
    sha256 = "sha256-plX3el5Vsfvqf0hV2NU2xS1wG9sax8Rm4eVlaiCEIb8=";
  };

  meta = with lib; {
    description = "Wombat gRPC Client";
    homepage = "https://github.com/rogchap/wombat";
    maintainers = [ maintainers.frekw ];
    platforms = platforms.darwin;
  };
}
