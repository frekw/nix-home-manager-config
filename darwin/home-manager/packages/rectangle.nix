 { stdenv, fetchurl, undmg }:

# TODO: Make configurable.
 stdenv.mkDerivation rec {
   pname = "rectangle";
   version = "0.63";
 
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
     sha256 = "sha256-xgO9fqf8PX0SwEsMVef3pBiaLblTgo9ZNrqHUn0+JIg=";
   };
 
   meta = with stdenv.lib; {
     description = "Rectangle window manager";
     homepage = "https://rectangleapp.com";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
 }