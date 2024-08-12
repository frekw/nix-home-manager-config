{ ... }:
{
  programs.rio = {
    enable = false;
    settings = {
      line-height = 1.1;
      blinking-cursor = true;
      padding-x = 60;
      window = {
        background-opacity = 0.75;
        decoration = "Disabled";
      };
      renderer = {
        performance = "Low";
      };
      fonts = {
        family = "Berkeley Mono";
        size = 24;
      };
    };
  };
}
