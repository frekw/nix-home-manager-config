{ fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "sloth";
  version = "v0.11.0";

  src = fetchFromGitHub {
    owner = "slok";
    repo = "sloth";
    rev = "v0.11.0";
    sha256 = "sha256-ENxpzL3m8jHKvWoyXFxvlwUkZOqmoePTCmaXd0aE4vo=";
  };

  subPackages = ["cmd/sloth"];

  vendorSha256 = "sha256-APIqB8P7Zfta62RPhy3iLcQNeYBZZgRjw5LC0A18ES0=";
}