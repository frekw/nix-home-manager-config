{ buildGoModule }:

buildGoModule rec {
  pname = "syb-cli";
  version = "81642dd";

  src = builtins.fetchGit {
    url = "git@github.com:soundtrackyourbrand/syb-cli.git";
    rev = "81642ddc5f62117b8fdba36eb37f9a8142ff44a7";
  };

  vendorSha256 = null;
}