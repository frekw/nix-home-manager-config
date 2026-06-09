{
  lib,
  stdenv,
  unzip,
}:

let
  packageJson = builtins.fromJSON (builtins.readFile ./package.json);
  version = "0.0.10";
  vsix = ./. + "/belt-vscode-${version}.vsix";
  vscodeExtPublisher = "soundtrack";
  vscodeExtName = "belt-vscode";
  vscodeExtUniqueId = "${vscodeExtPublisher}.${vscodeExtName}";
in

if !builtins.pathExists vsix then
  throw ''

    Belt VSCode extension not built.

    Before invoking this nix expression, run from the backend-main repo:

        belt vsix

    That produces ${toString vsix}, which this expression reads.
    The .vsix file is gitignored; it's a build artifact.

  ''
else
  stdenv.mkDerivation {
    name = "vscode-extension-${vscodeExtUniqueId}-${version}";
    inherit version;

    src = vsix;

    nativeBuildInputs = [ unzip ];

    # `.vsix` is a zip but stdenv's default unpackPhase doesn't recognise
    # the extension — drive the unzip explicitly.
    unpackPhase = ''
      runHook preUnpack
      mkdir -p extracted
      unzip -q "$src" -d extracted
      runHook postUnpack
    '';

    dontBuild = true;
    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      runHook preInstall
      extDir=$out/share/vscode/extensions/${vscodeExtUniqueId}
      mkdir -p "$extDir"
      cp -r extracted/extension/* "$extDir/"
      runHook postInstall
    '';

    # vscode-with-extensions reads these to name the symlink it creates.
    passthru = {
      inherit vscodeExtPublisher vscodeExtName vscodeExtUniqueId;
    };

    meta = {
      description = "Belt — Soundtrack backend-main service navigation";
      homepage = "https://github.com/soundtrackyourbrand/backend";
      platforms = lib.platforms.all;
    };
  }
