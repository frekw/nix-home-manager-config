{ config, ... }: {

  age.identityPaths = [ "/home/fredrikw/.ssh/id_ed25519" ];

  age.secrets.s-staging.file = ../../../secrets/s-staging.age;
  age.secrets.s-production.file = ../../../secrets/s-production.age;

  services.openvpn.servers = {
    s-staging = { config = "config ${config.age.secrets.s-staging.path}"; };
    s-production = {
      config = "config ${config.age.secrets.s-production.path}";
    };
  };
}
