{
  pkgs,
  lib,
  config,
  user,
  ...
}:
{
  options.modules.gaming = {
    minecraft = {
      enable = lib.mkEnableOption "minecraft";
    };
  };

  config = lib.mkIf config.modules.gaming.minecraft.enable {
    home-manager.users.${user.username} = {
      home.packages = with pkgs; [
        lunar-client
      ];
    };
  };
}
