{ stdenv, pkgs, lib, bash, makeWrapper, installShellFiles }:
stdenv.mkDerivation {
  name = "c";
  buildInputs = [ bash makeWrapper installShellFiles pkgs.kubectl ];

  # nothing to unpack
  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    cp ${./kube-context-switch.sh} $out/bin/c
    chmod +x $out/bin/c
    wrapProgram $out/bin/c --prefix PATH : ${lib.makeBinPath [ bash ]}
    patchShebangs $out/bin/c
    installShellCompletion --cmd c --zsh ${./kube-context-switch.zsh}
  '';
}
