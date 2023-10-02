 { stdenv, fetchurl, undmg }:

 stdenv.mkDerivation rec {
   pname = "obsidian";
   version = "1.4.13";
 
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r Obsidian.app "$out/Applications/Obsidian.app"
   '';
 
   src = fetchurl {
     name = "Obsidian-${version}-universal.dmg";
     url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/Obsidian-${version}-universal.dmg";
     sha256 = "sha256-FMaEq99D8bCQF91drHrB5icXyQIdnWIwhAM9yuG97aA=";
   };
 
   meta = with stdenv.lib; {
     description = "Obsidian";
     homepage = "https://obsidian.md/";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
 }