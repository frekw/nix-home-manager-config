{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    smartmontools
  ];

  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f6afc";
      }
      {
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f949b";
      }
      {
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f8e5a";
      }
      {
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f95c7";
      }
    ];
  };
}
