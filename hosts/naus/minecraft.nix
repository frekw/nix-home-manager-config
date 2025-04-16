{ ... }:
{
  virtualisation.oci-containers.containers = {
    minecraft = {
      environment = {
        ALLOW_CHEATS = "false";
        EULA = "TRUE";
        SERVER_NAME = "minecreft";
        TZ = "Europe/Paris";
        VERSION = "LATEST";
        PLUGINS = ''
          https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot
          https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot'';
        # ALLOW_LIST_USERS = "adyxax:2535470760215402,pseudo2:XXXXXXX,pseudo3:YYYYYYY";

      };
      image = "itzg/minecraft-server";
      ports = [
        "0.0.0.0:25565:25565"
        "0.0.0.0:19132:19132/udp"
      ];
      volumes = [ "/srv/minecraft/:/data" ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [ 19132 ];
  };
}
