{
  modulesPath,
  lib,
  pkgs,
  ...
}:
let
  hostname = "naus";
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./backup.nix
    ./hardware-configuration.nix
    ./users.nix
    ../../modules/base
    ./smartmon.nix
    ./samba.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdb2HLabEYCPyYyScJ9JHSQOAgbUy+phiTNZrRPd4qj fredrikw@um790"
  ];

  system.stateVersion = "24.11";

  modules.dev.github.enable = true;
  modules.programs.zsh.enable = true;
  modules.programs.zsh.hostname-in-prompt = true;
}
