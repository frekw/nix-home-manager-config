{ ... }:
let
  hostname = "um790";
in
{
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.extraHosts = ''
    192.168.68.53 naus
  '';
}
