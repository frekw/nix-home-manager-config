{pkgs, nur, user, mypkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = mypkgs.darwin.firefox;
    # extraPolicies = {
    #   DisableFirefoxStudies = true;
    #   DisablePocket = true;
    #   DisableTelemetry = true;
    #   DisableFirefoxAccounts = true;
    #   FirefoxHome = {
    #     Pocket = false;
    #     Snippets = false;
    #   };
    #   UserMessaging = {
    #     ExtensionRecommendations = false;
    #     SkipOnboarding = true;
    #   };
    # };
    profiles = {
      "${user.username}" = {
        id = 0;
        settings = {
          "app.update.auto" = false;
          "signon.rememberSignons" = false;
          "browser.casting.enabled" = true;
        };

        extensions = with nur.repos.rycee.firefox-addons; [
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