{
  programs.zsh.enable = true;

  users.users.fredrikw = {
    isNormalUser = true;
    description = "fredrikw";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
}
