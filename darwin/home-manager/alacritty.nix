{
  enable = true;

  settings = {
    env.TERM = "xterm-256color";

    window = {
      padding = {
        x = 33;
        y = 33;
      };

      decorations = "none";
    };

    scrolling = {
      history = 10000;
      multiplier = 3;
      faux_multiplier = 3;
    };

    tabspaces = 4;

    mouse_bindings = [
      {
        mouse = "Middle";
        action = "PasteSelection";
      }
    ];

    key_bindings = [
      {
        key = "V";
        mods = "Command";
        action = "Paste";
      }
      {
        key = "C";
        mods = "Command";
        action = "Copy";
      }
      {
        key = "Up";
        mods = "Control|Shift";
        action = "ScrollPageUp";
      }
      {
        key = "Down";
        mods = "Control|Shift";
        action = "ScrollPageDown";
      }
      {
        key = "N";
        mods = "Command";
        action = "SpawnNewInstance";
      }
      {
        key = "Q";
        mods = "Command";
        action = "Quit";
      }
      {
        key = "W";
        mods = "Command";
        action = "Quit";
      }
      {
        key = "Key0";
        mods = "Command";
        action = "ResetFontSize";
      }
      {
        key = "Equals";
        mods = "Command";
        action = "IncreaseFontSize";
      }
      {
        key = "Minus";
        mods = "Command";
        action = "DecreaseFontSize";
      }
    ];

    draw_bold_text_with_bright_colors = true;
    opacity = 1.0;

    font = {};

    cursor = {
      style = "Block";
      unfocused_hollow = true;
    };

    font = {
      normal = {
        family = "FiraCode Nerd Font";
        style = "Retina";
      };

      bold = {
        family = "FiraCode Nerd Font";
        style = "Bold";
      };

      italic = {
        family = "FiraCode Nerd Font";
        style = "Light";
      };

      size = 16.0;
    };

    colors = {
      primary = {
        background = "0x000000";
        foreground = "0xeeffff";
      };

      cursor = {
        text = "0x000000";
        cursor = "0xeeffff";
      };

      normal = {
        black = "0x000000";
        red = "0xF07178";
        green = "0x13CA91";
        yellow =  "0xFDF200";
        blue = "0x7898FB";
        magenta = "0xFF2079";
        cyan = "0x00FECA";
        white = "0xEEFFFF";
      };

      bright = {
        black = "0x4A4A4A";
        red = "0xF78C6C";
        green = "0x303030";
        yellow = "0x353535";
        blue = "0xB2CCD6";
        magenta = "0xEEFFFF";
        cyan = "0xFF5370";
        white = "0xFFFFFF";
      };
    };
  };
}