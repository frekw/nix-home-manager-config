{ pkgs, ... }:
let
  hostname = "m1";
in
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  nixpkgs.config.allowUnfree = true;

  home-manager.backupFileExtension = "bak";

  modules.dev.github.enable = true;
  modules.dev.melon-dance.enable = true;
  modules.env.work.enable = true;
  # modules.programs.ghostty.enable = true;
}
