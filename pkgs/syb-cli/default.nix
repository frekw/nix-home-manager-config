{ buildGoModule }:

buildGoModule rec {
  pname = "syb-cli";
  version = "33e3c5c";

  src = builtins.fetchGit {
    url = "git@github.com:soundtrackyourbrand/syb-cli.git";
    rev = "33e3c5c73f3a3e2d9a2c3664b2af2a90298c3bb3";
  };

  vendorHash = null;
}
