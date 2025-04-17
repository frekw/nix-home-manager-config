{
  pkgs,
  config,
  user,
  ...
}:
{
  age.secrets = {
    "minecraft/rcon".file = ../../secrets/minecraft/rcon.age;
  };

  systemd.tmpfiles.settings = {
    "20-minecraft" = {
      "/srv/minecraft" = {
        d = {
          group = "nogroup";
          mode = "0775";
          user = "nobody";
        };
      };
    };
  };

  virtualisation.oci-containers.containers = {
    minecraft = {
      serviceName = "minecraft";
      image = "itzg/minecraft-server";
      ports = [
        "0.0.0.0:25565:25565"
        "0.0.0.0:25575:25575"
        "0.0.0.0:19132:19132/udp"
      ];
      extraOptions = [
        "--memory=4G"
      ];

      environmentFiles = [
        config.age.secrets."minecraft/rcon".path
      ];

      environment = {
        ALLOW_CHEATS = "false";
        EULA = "TRUE";
        TYPE = "PAPER";
        PAPER_CHANNEL = "experimental";
        DIFFICULTY = "easy";
        SERVER_NAME = "minecreft";
        TZ = "Europe/Paris";
        VERSION = "1.21.5";

        ENABLE_RCON = "true";
        RCON_PORT = "25575";

        MEMORY = "";
        ENABLE_WHITELIST = "true";
        WHITELIST = "40e195fe-6fe9-4c31-a263-b446851bbe12,00000000-0000-0000-0009-01f9df2f1ded,00000000-0000-0000-0009-01facc8a9af9,81fcd61d-5091-450d-b7ee-7fc81bba5ca8,00000000-0000-0000-01F3-BA3C24DA";
        SEED = "44647503765050661";
        PLUGINS = ''
          https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot
          https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot'';

      };
      volumes = [ "/srv/minecraft/:/data" ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      25565
      25575 # rcon
    ];
    allowedUDPPorts = [ 19132 ];
  };
}
