{ buildGoModule }:

buildGoModule rec {
  pname = "syb-cli";
  version = "81642dd";

  src = builtins.fetchGit {
    url = "git@github.com:soundtrackyourbrand/syb-cli.git";
    rev = "abbfadecdab72aa59768be068ea08321a624f152";
  };

  vendorSha256 = null;
}