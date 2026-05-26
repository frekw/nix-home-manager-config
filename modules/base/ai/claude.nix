{ ... }:
{
  programs.claude-code = {
    enable = true;
    settings = {
      enabledPlugins = {
        "superpowers@claude-plugins-official" = true;
      };
    };
  };
}
