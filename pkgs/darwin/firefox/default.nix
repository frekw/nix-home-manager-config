{
  stdenv,
  lib,
  fetchurl,
  undmg,
  ...
}:

stdenv.mkDerivation rec {
  pname = "firefox-darwin";
  version = "145.0.1";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r Firefox.app "$out/Applications/Firefox.app"
  '';

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
    sha256 = "sha256-gozPxIU0rJdtu3ERO3kEXL/qtAHIEpjqW3Wo3WIjJIQ=";
  };

  meta = with lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-US/firefox";
    maintainers = [ maintainers.frekw ];
    platforms = platforms.darwin;
  };
}
