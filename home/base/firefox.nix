{ pkgs, config, rycee-ff, user, mypkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = mypkgs.darwin.firefox;
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
        settings = {
          "app.update.auto" = false;
          "signon.rememberSignons" = false;
          "browser.casting.enabled" = true;
        };

        extensions = with rycee-ff.packages."${pkgs.system}"; [
          istilldontcareaboutcookies
          react-devtools
          reddit-enhancement-suite
          ublock-origin
          unpaywall
        ];
      };
    };
  };
}
