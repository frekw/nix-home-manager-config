{ lib, pkgs, ... }:
{
  # programs.ssh = {
  #   enable = true;
  #   enableDefaultConfig = false;
  #   # matchBlocks = {
  #   #   "*" = {
  #   #     forwardAgent = false;
  #   #     addKeysToAgent = "no";
  #   #     compression = false;
  #   #     serverAliveInterval = 0;
  #   #     serverAliveCountMax = 3;
  #   #     hashKnownHosts = false;
  #   #     userKnownHostsFile = "~/.ssh/known_hosts";
  #   #     controlMaster = "no";
  #   #     controlPath = "~/.ssh/master-%r@%n:%p";
  #   #     controlPersist = "no";
  #   #   };
  #   # };
  #   # extraConfig = ''
  #   #   IgnoreUnknown UseKeychain
  #   #   AddKeysToAgent yes
  #   #   UseKeychain yes
  #   #   IdentityFile ~/.ssh/id_ed25519
  #   # '';
  # };

  programs.ssh.enable = false;
  home.packages = with pkgs; [ openssh ];

  # work around to get 600 permissions on .ssh/config
  home.file.".ssh/config_link" = {
    text = ''
      Host *
        ForwardAgent no
        AddKeysToAgent no
        Compression no
        ServerAliveInterval 0
        ServerAliveCountMax 3
        HashKnownHosts no
        UserKnownHostsFile ~/.ssh/known_hosts
        ControlMaster no
        ControlPath ~/.ssh/master-%r@%n:%p
        ControlPersist no

      # Extra custom lines you used to put in extraConfig
      IgnoreUnknown UseKeychain
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_ed25519
    '';

    onChange = ''
      rm -rf $HOME/.ssh/config
      cat $HOME/.ssh/config_link > $HOME/.ssh/config
      rm $HOME/.ssh/config_link
      chmod 600 $HOME/.ssh/config
    '';

    force = true;
  };
}
