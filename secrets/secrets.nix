let
  m1 =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZ8YlOC8kdpHJkDP04fJW7Aly3lqCac1N3aouyilzQm";

  um790 =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdb2HLabEYCPyYyScJ9JHSQOAgbUy+phiTNZrRPd4qj";

  hosts = [ m1 um790 ];
in {
  "github-token.age".publicKeys = hosts;
  "s-production.age".publicKeys = hosts;
  "s-staging.age".publicKeys = hosts;
}
