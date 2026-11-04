{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];


  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  modules.desktop.cosmic.enable = true;
  modules.desktop.umbriel.enable = true;
  # FreeSync only for fullscreen (games, video); HDR only when fullscreen
  # content actually sends HDR, so the desktop stays SDR.
  modules.desktop.umbriel.outputs."LG Electronics LG ULTRAGEAR 109MAMB4BA07" = {
    vrr = "fullscreen";
    hdr = "auto";
  };
  modules.desktop.hyprland.enable = false;

  modules.dev.github.enable = true;
  modules.dev.melon-dance.enable = true;
  modules.dev.zed.enable = true;

  modules.env.ai.enable = true;
  modules.env.ai.ollama.enable = true;
  modules.env.work.enable = true;

  modules.programs.cloudflare-warp.enable = true;
  modules.programs.ghostty.enable = true;
  modules.programs.nushell.enable = true;

  modules.gaming.minecraft.enable = true;

  home-manager.backupFileExtension = "bak";
}
