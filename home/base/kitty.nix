{ ... }:
{
  programs.kitty = {
    enable = false;
    font = {
      name = "BerkeleyMono-Regular";
      size = 14;
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      window_padding_width = "15 30 0";
    };
  };
}
