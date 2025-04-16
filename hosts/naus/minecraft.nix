{ ... }:
{
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
        "0.0.0.0:19132:19132/udp"
      ];
      extraOptions = [
        "--memory=4G"
      ];
      environment = {
        ALLOW_CHEATS = "false";
        EULA = "TRUE";
        TYPE = "PAPER";
        DIFFICULTY = "easy";
        SERVER_NAME = "minecreft";
        TZ = "Europe/Paris";
        VERSION = "LATEST";
        MEMORY = "";
        ENABLE_WHITELIST = "true";
        WHITELIST = "40e195fe-6fe9-4c31-a263-b446851bbe12";
        SEED = "44647503765050661";
        PLUGINS = ''
          https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot
          https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot'';

      };
      volumes = [ "/srv/minecraft/:/data" ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [ 19132 ];
  };
}
