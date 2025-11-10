{
  pkgs,
  config,
  rycee-ff,
  user,
  ...
}:
{
  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.darwinPackages.firefox else pkgs.firefox;
    policies = {
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
    profiles = {
      "${user.username}" = {
        id = 0;
        isDefault = true;
        settings = {
          "app.update.auto" = false;
          "signon.rememberSignons" = false;
          "browser.casting.enabled" = true;
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };

        extensions = {
          packages = with rycee-ff.packages."${pkgs.stdenv.hostPlatform.system}"; [
            istilldontcareaboutcookies
            react-devtools
            reddit-enhancement-suite
            ublock-origin
            unpaywall
          ];
        };
      };
    };
  };
}
