 { stdenv, fetchurl, undmg }:

 stdenv.mkDerivation rec {
   pname = "tunnelblick";
   version = "3.8.8d";
 
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r Tunnelblick.app "$out/Applications/Tunnelblick.app"
   '';
 
   src = fetchurl {
     name = "Tunnelblick_${version}_build_5779.dmg";
     url = "https://tunnelblick.net/iprelease/Tunnelblick_3.8.8d_build_5779.dmg";
     sha256 = "sha256-QWtb4HoR0SXqU5nRq5XX3gxcu2Z7AROakJEwNGSsDi0=";
   };
 
   meta = with stdenv.lib; {
     description = "Tunnelblick VPN";
     homepage = "https://tunnelblick.net/";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
 }