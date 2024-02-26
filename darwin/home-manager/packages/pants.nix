{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "pantsbuild.pants";
  version = "0.10.7";

  src = fetchFromGitHub {
    owner = "pantsbuild";
    repo = "scie-pants";
    rev = "v${version}";
    hash = "sha256-Zi60HIEW/4klMRPy70+ji1joxPTw9Y6QibmnGkXRQoY=";
  };

  cargoHash = "sha256-M2XTYi9svX9QVizNSRPyY1N0d98KLL9xDbNIXWXil90=";

  postInstall = ''
    cp $out/bin/scie-pants $out/bin/pants
  '';

  meta = with lib; {
    description = "A build system for software projects in a variety of languages";
    homepage    = "https://www.pantsbuild.org/";
    license     = licenses.asl20;
    maintainers = [ maintainers.frekw ];
  };
}