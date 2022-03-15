 { stdenv, fetchurl, undmg }:

# TODO: Make configurable.
 stdenv.mkDerivation rec {
   pname = "rectangle";
   version = "0.51";
 
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r Rectangle.app "$out/Applications/Rectangle.app"
   '';
 
   src = fetchurl {
     name = "Rectangle${version}.dmg";
     url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
     sha256 = "ed0c1e4634471f3c095ed1331611f8fb859f47febcdc9c2c4aba670f7db3a5bb";
   };
 
   meta = with stdenv.lib; {
     description = "Rectangle window manager";
     homepage = "https://rectangleapp.com";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
 }