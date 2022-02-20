{ stdenv, fetchurl, xar, cpio }:

stdenv.mkDerivation rec {
  pname = "1password-gui";
  version = "7.9.2";

  meta = with stdenv.lib; {
    description = "1Password password manager";
    homepage = "https://1password.com/downloads/mac/";
    maintainers = [ maintainers.frekw ];
    platforms = platforms.darwin;
  };

  src = fetchurl {
    url = "https://c.1password.com/dist/1P/mac7/1Password-${version}.pkg";
    sha256 = "c1e0b2235388d1a8e7639ff752beb102d2bac89dbb89b20cee8d76701355e977";
  };

  buildInputs = [ xar cpio ];

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    runHook preUnpack

    xar -xf $src
    cat 1Password.pkg/Payload | gunzip -dc | cpio -i

    runHook postUnpack
  '';

  sourceRoot = "1Password\ 7.app";

  appName = "1Password.app";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications/${appName}
    cp -r . $out/Applications/${appName}

    runHook postInstall
  '';
}