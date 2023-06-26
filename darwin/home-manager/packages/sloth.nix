{ fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "sloth";
  version = "v0.11.0";

  src = fetchFromGitHub {
    owner = "slok";
    repo = "sloth";
    rev = "v0.11.0";
		sha256 = "sha256-KMVD7uH3Yg9ThnwKKzo6jom0ctFywt2vu7kNdfjiMCs=";
  };

  subPackages = ["cmd/sloth"];

	vendorSha256 = "sha256-j6qXUQ/Tu3VNQL5xBOHloRn5DH3KG/znCLi1s8RIoL8=";
}
