{ pkgs, ... }:
let
  hostname = "m1";
in
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  nixpkgs.config.allowUnfree = true;

  modules.dev.github.enable = true;
  modules.env.work.enable = true;
}
