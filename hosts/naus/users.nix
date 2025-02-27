{ pkgs, user, ... }@input:
{
  programs.zsh.enable = true;

  users.users.fredrikw = {
    isNormalUser = true;
    description = "fredrikw";
    extraGroups = [
      "docker"
      "networkmanager"
      "smbgroup"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdb2HLabEYCPyYyScJ9JHSQOAgbUy+phiTNZrRPd4qj fredrikw@um790"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "fredrikw" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit user; };
  home-manager.users."${user.username}" = import ./home.nix;
}
