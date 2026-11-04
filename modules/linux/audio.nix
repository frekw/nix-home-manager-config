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

        # Let the output follow the source's sample rate instead of resampling
        # everything to 48 kHz, so 44.1 kHz music reaches the DAC untouched and
        # hi-res files play at their own rate. PipeWire only switches rate while
        # the device is idle; mixed sources play at the current rate.
        # (Settings must sit under context.properties; top-level keys like
        # `clock.rate` are silently ignored, which is what this file had before.)
        "10-sample-rates" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [
              44100
              48000
              88200
              96000
              176400
              192000
            ];
          };
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
      };
    };
  };
}
