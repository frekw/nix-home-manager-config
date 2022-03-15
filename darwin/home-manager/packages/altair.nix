{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
   pname = "altair-darwin";
   version = "4.4.0";
 
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r "Altair GraphQL Client.app" "$out/Applications/Altair.app"
   '';
 
   src = fetchurl {
     name = "Altair-${version}.dmg";
     url = "https://github.com/altair-graphql/altair/releases/download/v${version}/altair_${version}_arm64_mac.dmg";
     sha256 = "b7652b449fd9709a1af0875fbd34a37798807ece50c927b3465cdc35661c5fe8";
   };
 
   meta = with stdenv.lib; {
     description = "The Altair GraphQL Client";
     homepage = "https://altair.sirmuel.design/";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
}