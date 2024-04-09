{ ... }: {
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # recommended for pipewire
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    extraConfig = {
      pipewire = {
        default.clock.rate = 48000;
        default.clock.allowed-rates = [ 44100 48000 96000 192000 ];
        default.clock.quantum = 1024;
        default.clock.min-quantum = 16;
        default.clock.max-quantum = 4096;
        default.clock.quantum-limit = 8192;
        default.video.width = 640;
        default.video.height = 480;
        default.video.rate.num = 25;
        default.video.rate.denom = 1;
        settings.check-quantum = false;
        settings.check-rate = false;
        # These overrides are only applied when running in a vm.
        vm.overrides = { default.clock.min-quantum = 1024; };
      };
    };
  };
}
