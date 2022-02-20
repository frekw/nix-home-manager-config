 { stdenv, fetchurl, undmg }:

 stdenv.mkDerivation rec {
   pname = "firefox-darwin";
   version = "97.0.1";
 
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r Firefox.app "$out/Applications/Firefox.app"
   '';
 
   src = fetchurl {
     name = "Firefox-${version}.dmg";
     url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
     sha256 = "172f90d0a2165d7abee8e5d5fdf578dd3f94d88b552c6d6f7c285480fa8f7afa";
   };
 
   meta = with stdenv.lib; {
     description = "The Firefox web browser";
     homepage = "https://www.mozilla.org/en-US/firefox";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
 }