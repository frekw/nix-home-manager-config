{ stdenv, fetchurl, xar, cpio }:

stdenv.mkDerivation rec {
  pname = "1password-gui";
  version = "7.9.5";

  meta = with stdenv.lib; {
    description = "1Password password manager";
    homepage = "https://1password.com/downloads/mac/";
    maintainers = [ maintainers.frekw ];
    platforms = platforms.darwin;
  };

  src = fetchurl {
    url = "https://c.1password.com/dist/1P/mac7/1Password-${version}.pkg";
    sha256 = "0xcnnaxyzchp66blr5wc0y52ip3xasz65cksvdwhrgphrpj58s12";
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