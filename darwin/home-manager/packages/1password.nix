{ stdenv, fetchurl, xar, cpio }:

stdenv.mkDerivation rec {
  pname = "1password-gui";
  version = "7.9.3";

  meta = with stdenv.lib; {
    description = "1Password password manager";
    homepage = "https://1password.com/downloads/mac/";
    maintainers = [ maintainers.frekw ];
    platforms = platforms.darwin;
  };

  src = fetchurl {
    url = "https://c.1password.com/dist/1P/mac7/1Password-${version}.pkg";
    sha256 = "7e86ee75d3cda17dca95f941621bfe2c15b3011c2f4a29e3f24226bf7c37718a";
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