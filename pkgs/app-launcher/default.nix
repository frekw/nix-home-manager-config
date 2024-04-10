{ stdenv, lib, bash, makeWrapper, installShellFiles }:
stdenv.mkDerivation {
  name = "app";
  buildInputs = [ bash makeWrapper installShellFiles ];

  # nothing to unpack
  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    cp ${./app-launcher.sh} $out/bin/app
    chmod +x $out/bin/app
    wrapProgram $out/bin/app --prefix PATH : ${lib.makeBinPath [ bash ]}
    patchShebangs $out/bin/app
    installShellCompletion --cmd app --zsh ${./app.zsh}
  '';
}
