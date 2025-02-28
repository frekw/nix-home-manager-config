{ pkgs, ... }:
{
  users.groups.smbgroup = { };
  users.users.smbuser = {
    isSystemUser = true;
    description = "samba";
    group = "smbgroup";
  };

  systemd.tmpfiles.settings = {
    "10-samba" = {
      "/mnt/share/public" = {
        d = {
          group = "smbgroup";
          mode = "0775";
          user = "smbuser";
        };
      };
    };
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # remember to use smbpasswd to setup samba users
  # sudo smbpasswd -a nobody
  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true;
    settings = {
      global = {
        security = "user";
        "server string" = "naus";
        "netbios name" = "naus";
        "workgroup" = "WORKGROUP";

        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.68. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "map to guest" = "bad user";
        # "browseable" = "yes";
        # "public" = "yes";
        # "guest ok" = "yes";
        "guest only" = "yes";

        # "force user" = "smbuser";
        # "force group" = "smbgroup";

        # Security
        # this breaks guest logins
        # "smb encrypt" = "required";
        "client ipc max protocol" = "SMB3";
        "client ipc min protocol" = "SMB2_10";
        "client max protocol" = "SMB3";
        "client min protocol" = "SMB2_10";
        "server max protocol" = "SMB3";
        "server min protocol" = "SMB2_10";

        # Performance
        # socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072
        # read raw = yes
        # write raw = yes
        # server signing = no
        # strict locking = no
        "min receivefile size" = 16384;
        "use sendfile" = "yes";
        # aio read size = 16384
        # aio write size = 16384
      };
      public = {
        "path" = "/mnt/share/public";
        "create mask" = "0664";
        "directory mask" = "0775";

        "browseable" = "yes";
        "read only" = "no";
        "preserve case" = "yes";

        "guest ok" = "yes";

        "force user" = "smbuser";
        "force group" = "smbgroup";

        "veto files" =
          "/.apdisk/.DS_Store/._*/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };
}
