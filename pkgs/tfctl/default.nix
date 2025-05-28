{
  fetchFromGitHub,
  buildGoModule,
  lib,
  ...
}:

buildGoModule rec {
  pname = "tfctl";
  version = "v0.15.1";

  src = fetchFromGitHub {
    owner = "flux-iac";
    repo = "tofu-controller";
    rev = "v0.15.1";
    sha256 = "sha256-rA3HLO4sD8UmcebGGFxyg0zFpDHCzFHjHwMxPw8MiRU=";
  };

  subPackages = [ "cmd/tfctl" ];

  vendorHash = "sha256-NhXgWuxSuurP46DBWOviFzCINJKaTb1mINRYeYcnnH8=";
}
