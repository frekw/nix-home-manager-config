{
  stdenv,
  lib,
  fetchurl,
  _7zz,
  ...
}:

stdenv.mkDerivation rec {
  pname = "altair-darwin";
  version = "7.3.4";

  nativeBuildInputs = [ _7zz ];
  # buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Altair GraphQL Client.app" "$out/Applications/Altair.app"
  '';

  src = fetchurl {
    name = "altair_${version}_arm64_mac.dmg";
    url = "https://github.com/altair-graphql/altair/releases/download/v${version}/altair_${version}_arm64_mac.dmg";
    sha256 = "sha256-Pi8xj8Ok/43vrFQ4aCbEOiaZx4nO0hKkioJ/8Jt7kjA=";
  };

  meta = with lib; {
    description = "The Altair GraphQL Client";
    homepage = "https://altair.sirmuel.design/";
    maintainers = [ maintainers.frekw ];
    platforms = platforms.darwin;
  };
}
