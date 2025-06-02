{ ... }:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

  # recommended for pipewire
  security.rtkit.enable = true;

  services.pipewire.wireplumber = {
    enable = true;
  };

  # avahi required for AirPlay service discovery
  services.avahi.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # opens UDP ports 6001-6002
    raopOpenFirewall = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    extraConfig = {
      pipewire = {

        default = {
          clock.rate = 48000;
          clock.allowed-rates = [
            44100
            48000
            96000
            192000
          ];
          clock.quantum = 1024;
          clock.min-quantum = 16;
          clock.max-quantum = 4096;
          clock.quantum-limit = 8192;
          video.width = 640;
          video.height = 480;
          video.rate.num = 25;
          video.rate.denom = 1;
        };

        settings = {
          check-quantum = false;
          check-rate = false;
        };

        "10-airplay" = {
          "context.modules" = [
            {
              name = "libpipewire-module-raop-discover";

              # increase the buffer size if you get dropouts/glitches
              # args = {
              #   "raop.latency.ms" = 500;
              # };
            }
          ];
        };

        # These overrides are only applied when running in a vm.
        vm.overrides = {
          default.clock.min-quantum = 1024;
        };
      };
    };
  };
}
