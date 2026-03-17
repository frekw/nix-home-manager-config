{
  pkgs,
  config,
  user,
  lib,
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
        "--network=host"
      ];

      environmentFiles = [
        config.age.secrets."minecraft/rcon".path
      ];

      environment = {
        ALLOW_CHEATS = "false";
        EULA = "TRUE";
        TYPE = "PAPER";
        PAPER_CHANNEL = "default";
        # PAPER_CHANNEL = "experimental";
        DIFFICULTY = "normal";
        ENFORCE_SECURE_PROFILE = "false";
        SERVER_NAME = "minecreft";
        TZ = "Europe/Paris";
        VERSION = "1.21.11";

        ENABLE_RCON = "true";
        RCON_PORT = "25575";

        INIT_MEMORY = "4G";
        MAX_MEMORY = "8G";

        ENABLE_WHITELIST = "true";
        OPS = lib.concatStringsSep "," [
          "40e195fe-6fe9-4c31-a263-b446851bbe12" # silas
        ];

        # for bedrock, use https://www.cxkes.me/xbox/xuid
        # search for the name, grab hex and rewrite it
        # to a uuid.

        WHITELIST = lib.concatStringsSep "," [
          "40e195fe-6fe9-4c31-a263-b446851bbe12" # silas
          "00000000-0000-0000-0009-01f9df2f1ded"
          "00000000-0000-0000-0009-01facc8a9af9"
          "81fcd61d-5091-450d-b7ee-7fc81bba5ca8"
          "00000000-0000-0000-0009-01f3ba3c24da"
          "13b08c97-0e84-4a56-b10c-a84bacac95ed"
          "97edccda-abeb-42e7-8445-4983f1d05e36"
          "00000000-0000-0000-0009-01f5a548fbe9" # harry
          "00000000-0000-0000-0009-01f17f0f6f84"
          "c38fdca1-5d5a-4b69-8af6-d345d9f9feaf" # albin
          "bf8c7d2a-660f-4abe-9331-5e60473611d1" # oliver
          "00000000-0000-0000-0009-01fff9906934" # alfred
          "00000000-0000-0000-0009-0000069cf4bc" # niklas
          "00000000-0000-0000-0009-01f22f468185" # annie
        ];
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
