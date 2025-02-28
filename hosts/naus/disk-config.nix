{ pkgs, ... }:
{

  # disk 1 /dev/disk/by-id/wwn-0x5000c500fa9f6afc
  # disk 2 /dev/disk/by-id/wwn-0x5000c500fa9f949b
  # disk 3 /dev/disk/by-id/wwn-0x5000c500fa9f8e5a
  # disk 4 /dev/disk/by-id/wwn-0x5000c500fa9f95c7

  # shouldn't be needed, but this is the default in nix.
  networking.hostId = "8425e349";

  disko.devices = {
    disk = {
      root = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };

      disk0 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f6afc";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
      disk1 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f949b";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f8e5a";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
      disk3 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000c500fa9f95c7";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "storage";
              };
            };
          };
        };
      };
    };
    zpool = {
      storage = {
        type = "zpool";
        mode = "raidz1";
        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          xattr = "sa";
          "com.sun:auto-snapshot" = "false";
        };
        datasets = {
          share = {
            type = "zfs_fs";
            mountpoint = "/mnt/share";
          };
        };
      };
    };
  };

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
