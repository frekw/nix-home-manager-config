{ buildGoModule }:

buildGoModule rec {
  pname = "kubent";
  version = "1ce0aa9";

  src = builtins.fetchGit {
    url = "git@github.com:doitintl/kube-no-trouble.git";
    rev = "1ce0aa95059198f82e87bef3ba7a387db553beda";
  };

  vendorHash = null;

  preBuild = ''
  go mod tidy
  go mod vendor
  '';
}