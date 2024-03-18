{ buildGoModule }:

buildGoModule rec {
  pname = "syb-cli";
  version = "81642dd";

  src = builtins.fetchGit {
    url = "git@github.com:soundtrackyourbrand/syb-cli.git";
    rev = "a719e2325f3b639de91b295956fdbe63ddef3628";
  };

  vendorHash = null;
}