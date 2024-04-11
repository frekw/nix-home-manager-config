{ ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- This is where you actually apply your config choices

      -- For example, changing the color scheme:
      config.color_scheme = 'Dark Pastel'

      -- config.font = wezterm.font('Monaspace Neon')
      config.font = wezterm.font('Berkeley Mono')
      config.freetype_load_flags = 'NO_HINTING'
      config.freetype_load_target = 'Normal'
      config.line_height = 1.0
      config.font_size = 16
      config.enable_tab_bar = false
      config.window_padding = {
        left = "60px",
        right = "60px",
        top = "60px",
        bottom = "60px",
      }
      config.window_decorations = "RESIZE | MACOS_FORCE_DISABLE_SHADOW"


      -- and finally, return the configuration to wezterm
      return config
    '';
  };
}
