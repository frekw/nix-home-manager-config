let
  m1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZ8YlOC8kdpHJkDP04fJW7Aly3lqCac1N3aouyilzQm";

  um790 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdb2HLabEYCPyYyScJ9JHSQOAgbUy+phiTNZrRPd4qj";

  naus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBRInoycHSxTTDmn20keuaZynp+1cY1Gflvh4LcF+3ia";

  workHosts = [
    m1
    um790
  ];

  allHosts = [
    m1
    um790
    naus
  ];

  homeHosts = [
    um790
    naus
  ];
in
{
  "github-token.age".publicKeys = allHosts;
  "s-production.age".publicKeys = workHosts;
  "s-staging.age".publicKeys = workHosts;
  "terraformrc.age".publicKeys = workHosts;
  "npmrc.age".publicKeys = workHosts;

  "restic/env.age".publicKeys = homeHosts;
  "restic/repo.age".publicKeys = homeHosts;
  "restic/password.age".publicKeys = homeHosts;
}
