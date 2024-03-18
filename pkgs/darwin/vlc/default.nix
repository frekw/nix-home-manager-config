 { stdenv, fetchurl, undmg }:

 stdenv.mkDerivation rec {
   pname = "obsidian";
   version = "3.0.18";
 
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r VLC.app "$out/Applications/VLC.app"
   '';
 
   src = fetchurl {
     name = "Obsidian-${version}-universal.dmg";
     url = "https://get.videolan.org/vlc/${version}/macosx/vlc-${version}-arm64.dmg";
     sha256 = "sha256-mcJZvbxSIf1QgX9Ri3Dpv57hdeiQdDkDyYB7x3hmj0c=";
   };
 
   meta = with stdenv.lib; {
     description = "VLC";
     homepage = "https://https://www.videolan.org/vlc//";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };
 }