{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
   pname = "altair-darwin";
   version = "5.0.23";
 
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
     sha256 = "sha256-vrnWDY6nfW+D5j4R5q261Ebjka6ctOOVBfk6ISIeP9s=";
   };
 
   meta = with stdenv.lib; {
     description = "The Altair GraphQL Client";
     homepage = "https://altair.sirmuel.design/";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
}