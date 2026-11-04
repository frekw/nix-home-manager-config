{
  lib,
  config,
  pkgs,
  user,
  umbriel,
  noctalia,
  umbriel-shaders,
  ...
}:
let
  cfg = config.modules.desktop.umbriel;
  ghostty = config.modules.programs.ghostty.enable;
  tomlFormat = pkgs.formats.toml { };

  noctaliaMsg = cmd: "spawn noctalia msg ${cmd}";
  # Screenshots default to clipboard only (shell.screenshot.save_to_file = false).
  saveShot = "--save-to-file --no-copy-to-clipboard";
  once = action: {
    inherit action;
    repeat = false;
  };
  whenLocked = action: {
    inherit action;
    allow_when_locked = true;
  };

  shaderEffects = lib.unique (
    lib.filter (e: e != null) [
      cfg.windowAnimation.open
      cfg.windowAnimation.close
    ]
  );

  windowAnimationEvent = effect: {
    enabled = true;
    inherit effect;
    duration_ms = cfg.windowAnimation.duration;
    # The shaders do their own easing.
    curve = "linear";
  };

  workspaceBinds = lib.listToAttrs (
    lib.concatMap (n: [
      (lib.nameValuePair "Mod+${toString n}" "workspace-switch ${toString n}")
      (lib.nameValuePair "Mod+Shift+${toString n}" "window-move-to-workspace ${toString n}")
    ]) (lib.range 1 9)
  );

  # Mod+<key> focuses, Mod+Shift+<key> moves. Arrows and vim keys both work, like COSMIC.
  directionBinds = lib.concatMapAttrs (
    dir: keys:
    lib.listToAttrs (
      lib.concatMap (key: [
        (lib.nameValuePair "Mod+${key}" "window-focus-or-output-${dir}")
        (lib.nameValuePair "Mod+Shift+${key}" "window-move-${dir}")
      ]) keys
    )
  ) {
    left = [ "Left" "H" ];
    down = [ "Down" "J" ];
    up = [ "Up" "K" ];
    right = [ "Right" "L" ];
  };

  # The Nix-managed Umbriel config. config.toml only includes it, followed by
  # files that are allowed to override it:
  #   noctalia.toml - colors written by Noctalia's Umbriel theme template
  #   local.toml    - hand edits that apply on save, no rebuild needed
  umbrielSettings = {
    general.autostart = [ "noctalia" ];

    # Shader paths inside each effect.toml resolve next to it, so pointing at
    # the store copy of the repo is enough.
    include.files = map (e: "${umbriel-shaders}/animation/${e}/effect.toml") shaderEffects;

    animation = {
      enabled = true;
    }
    // lib.optionalAttrs (cfg.windowAnimation.open != null) {
      windows_in = windowAnimationEvent cfg.windowAnimation.open;
    }
    // lib.optionalAttrs (cfg.windowAnimation.close != null) {
      windows_out = windowAnimationEvent cfg.windowAnimation.close;
    };

    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    input = {
      keyboard = {
        inherit (cfg.keyboard) layout variant options;
        repeat_rate = 45;
        repeat_delay = 300;
        numlock_toggle = true;
      };
      mouse = {
        accel_profile = "flat";
        sensitivity = 0.3;
      };
      touchpad = {
        tap = true;
        natural_scroll = true;
      };
    };

    layout = {
      mode = cfg.layout;
      gap = 8;
      extent_presets = [
        0.333
        0.5
        0.667
      ];
      scrolling.default_extent_fraction = 0.5;
    };

    appearance = {
      prefer_no_csd = true;
      border_width = 2;
      corner_radius = 10;
      title_bar.font = "SF Pro 10";
      tab_bar.font = "SF Pro 10";
      blur = {
        enabled = true;
        optimized = true;
        passes = 2;
        radius = 3;
        noise = 2.0e-2;
        brightness = 0.9;
        contrast = 0.9;
        saturation = 1.1;
      };
    };

    hot_corners.top_left = {
      enabled = true;
      delay_ms = 500;
      action = "overview-open";
    };

    keybinds =
      workspaceBinds
      // directionBinds
      // {
        # Launchers and apps (COSMIC: Super opens the launcher, Super+A app library)
        "Mod" = noctaliaMsg "panel-toggle launcher";
        "Mod+A" = once (noctaliaMsg "panel-toggle launcher");
        "Mod+T" = once "spawn ${cfg.terminal}";
        "Mod+Return" = once "spawn ${cfg.terminal}";
        "Mod+B" = once "spawn ${cfg.browser}";
        "Mod+F" = once "spawn ${cfg.fileManager}";

        # Shell panels
        "Mod+S" = once (noctaliaMsg "panel-toggle control-center");
        "Mod+V" = once (noctaliaMsg "panel-toggle clipboard");
        # Emoji picker; the chosen emoji is pasted into the focused window.
        "Mod+Period" = once (noctaliaMsg "panel-toggle launcher /emo");
        "Mod+Comma" = once (noctaliaMsg "settings-toggle");
        # Umbriel's overlay listing every active keybind.
        "Mod+Slash" = once "cheatsheet-toggle";
        "Alt+Tab" = noctaliaMsg "window-switcher hold";
        "Alt+Shift+Tab" = noctaliaMsg "window-switcher hold reverse";
        "Print" = once (noctaliaMsg "screenshot-region");
        # macOS-style screenshot keys, flipped so the common case is shorter:
        # Mod+Shift+<key> copies to the clipboard, adding Ctrl saves to ~/Pictures
        # instead. S region, A whole monitor, W window.
        "Mod+Shift+S" = once (noctaliaMsg "screenshot-region");
        "Mod+Ctrl+Shift+S" = once (noctaliaMsg "screenshot-region ${saveShot}");
        "Mod+Shift+A" = once (noctaliaMsg "screenshot-fullscreen");
        "Mod+Ctrl+Shift+A" = once (noctaliaMsg "screenshot-fullscreen ${saveShot}");
        "Mod+Shift+W" = once (noctaliaMsg "screenshot-window");
        "Mod+Ctrl+Shift+W" = once (noctaliaMsg "screenshot-window ${saveShot}");

        # Session
        "Mod+Escape" = once (noctaliaMsg "session lock");
        "Mod+Shift+Escape" = once (noctaliaMsg "panel-toggle session");
        "Mod+Ctrl+Escape" = {
          action = "shortcuts-inhibit-toggle";
          allow_when_inhibited = true;
          repeat = false;
        };

        # Windows
        "Mod+Q" = once "window-close";
        "Mod+M" = once "window-toggle-maximize-to-edges";
        "Mod+Shift+F" = once "window-toggle-fullscreen";
        "Mod+G" = once "window-toggle-floating";
        "Mod+P" = once "window-toggle-pinned";
        "Mod+Minus" = "window-modify-primary-extent -0.05";
        "Mod+Equal" = "window-modify-primary-extent +0.05";
        "Mod+Ctrl+Minus" = "window-modify-secondary-extent -0.05";
        "Mod+Ctrl+Equal" = "window-modify-secondary-extent +0.05";
        "Mod+R" = "window-cycle-primary-extent";

        # Scratchpad: windows stored off-workspace, shown and hidden together.
        "Mod+Shift+Space" = once "window-move-to-scratchpad";
        "Mod+Space" = once "scratchpad-toggle";
        "Mod+Ctrl+Space" = once "window-restore-from-scratchpad";
        "Mod+Tab" = "scratchpad-focus-next";

        # Layout (COSMIC: Super+Y toggles tiling, Super+O flips orientation)
        "Mod+Y" = once "workspace-set-layout toggle ${cfg.layout} stacking";
        # Flip between scrolling and tiling while deciding which to keep.
        "Mod+Shift+Y" = once "workspace-set-layout toggle scrolling dwindle";
        "Mod+O" = once "layout-toggle-split";
        "Mod+W" = once "overview-toggle";

        # Workspaces (COSMIC horizontal workspaces: Super+Ctrl+Left/Right)
        "Mod+Ctrl+Left" = "workspace-previous";
        "Mod+Ctrl+Right" = "workspace-next";
        "Mod+Ctrl+H" = "workspace-previous";
        "Mod+Ctrl+L" = "workspace-next";
        "Mod+Ctrl+Shift+Left" = "window-move-to-workspace-previous";
        "Mod+Ctrl+Shift+Right" = "window-move-to-workspace-next";
        "Mod+WheelUp" = "workspace-previous";
        "Mod+WheelDown" = "workspace-next";

        # Hardware keys go through Noctalia so its OSD shows.
        "XF86AudioRaiseVolume" = whenLocked (noctaliaMsg "volume-up");
        "XF86AudioLowerVolume" = whenLocked (noctaliaMsg "volume-down");
        "XF86AudioMute" = whenLocked (noctaliaMsg "volume-mute") // {
          repeat = false;
        };
        "XF86AudioPlay" = whenLocked (noctaliaMsg "media toggle") // {
          repeat = false;
        };
        "XF86AudioNext" = whenLocked (noctaliaMsg "media next");
        "XF86AudioPrev" = whenLocked (noctaliaMsg "media previous");
        "XF86MonBrightnessUp" = whenLocked (noctaliaMsg "brightness-up");
        "XF86MonBrightnessDown" = whenLocked (noctaliaMsg "brightness-down");
      };

    window_rule = [
      { blur = true; }
      {
        match.app_id = "^dev.noctalia.Noctalia$";
        default_floating = true;
        default_floating_size_px = {
          width = 1020;
          height = 900;
        };
      }
      {
        match.app_id = "^dev.noctalia.UmbrielSharePicker$";
        default_floating = true;
        default_floating_size_px = {
          width = 800;
          height = 600;
        };
      }
      {
        match.title = "^(Picture-in-Picture|Picture in picture)$";
        default_floating = true;
        default_maximize = false;
        default_position = {
          x = 20;
          y = 20;
          anchor = "bottom_right";
        };
      }
    ];

    layer_rule = [
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
        blur = true;
        blur_ignore_alpha = 0.5;
        blur_popups = true;
      }
      {
        match.namespace = "^noctalia-(notification|dock|panel|attached-panel|osd)$";
        blur_optimized = false;
      }
    ];
  };
in
{
  home-manager.sharedModules = [
    umbriel.homeModules.default
    noctalia.homeModules.default
  ];

  home-manager.users.${user.username} = lib.mkIf cfg.enable {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    xdg.configFile."umbriel/nixos.toml".source = tomlFormat.generate "umbriel-nixos.toml" umbrielSettings;

    programs.umbriel = {
      enable = true;
      settings.include.optional.files = [
        "nixos.toml"
        "noctalia.toml"
        "local.toml"
      ];
    };

    # Settings changed in Noctalia's GUI land in ~/.local/state/noctalia/settings.toml
    # and win over this file, so tweaking from the UI still works.
    programs.noctalia = {
      enable = true;
      settings = {
        shell = {
          font_family = "SF Pro";
          screenshot.save_to_file = false;
          polkit_agent = true;
          umbriel_overview_type_to_launch_enabled = true;
          umbriel_overview_close_on_launch_enabled = true;
        };

        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Noctalia";
          # umbriel: writes ~/.config/umbriel/noctalia.toml so borders follow the palette.
          # ghostty: writes ~/.config/ghostty/themes/noctalia and live-reloads Ghostty.
          templates.builtin_ids = [
            "umbriel"
          ]
          ++ lib.optional ghostty "ghostty";
        };

        # Full-width bar, with workspaces in the middle.
        bar.main = {
          position = "top";
          thickness = 30;
          margin_ends = 0;
          radius = 0;
          # Defaults are 6 and 14, which crowd the status icons.
          widget_spacing = 14;
          padding = 16;
          start = [
            "launcher"
            "active_window"
          ];
          center = [
            "workspaces"
            "umbriel"
          ];
          end = [
            "tray"
            "keyboard_layout"
            "media"
            "network"
            "bluetooth"
            "volume"
            "battery"
            "notifications"
            "worldclock"
            "clock"
            "session"
          ];
        };

        # Shows the workspace's layout; click for a panel to switch layout,
        # resize/float the focused window, or jump between workspaces.
        plugins.enabled = [
          "noctalia/umbriel-companion"
          "noctalia/world_clock"
        ];
        widget.umbriel.type = "noctalia/umbriel-companion:bar";
        # Drop the "Nothing Playing" placeholder; paused players still show.
        widget.media.hide_when_no_media = true;
        # The zone list lives in the plugin's data dir, not here; it's managed
        # from the panel or `noctalia msg plugin noctalia/world_clock:service all add <zone>`.
        widget.worldclock = {
          type = "noctalia/world_clock:bar";
          show_clocks = true;
        };

        # COSMIC-style auto-hiding dock.
        dock = {
          enabled = true;
          position = "bottom";
          auto_hide = true;
          reserve_space = false;
          show_running = true;
          launcher_position = "start";
        };

        # Mirrors the old COSMIC idle settings: screen off after 30 min,
        # suspend after 90 min.
        idle.behavior = {
          lock = {
            enabled = true;
            action = "lock";
            timeout = 1500;
          };
          screen-off = {
            enabled = true;
            action = "screen_off";
            timeout = 1800;
          };
          suspend = {
            enabled = true;
            action = "lock_and_suspend";
            timeout = 5400;
          };
        };
      };
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    # nm-applet's autostart entry only skips KDE, GNOME and COSMIC, so under
    # Umbriel it puts a second Wi-Fi icon next to Noctalia's network widget.
    xdg.configFile."autostart/nm-applet.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=NetworkManager Applet
      Hidden=true
    '';

    # Ghostty's config is a read-only Home Manager symlink. Noctalia's template
    # hook only tries to edit it when the theme line isn't already exactly
    # "theme = noctalia", so set that here.
    programs.ghostty.settings = lib.mkIf ghostty {
      theme = lib.mkForce "noctalia";
      background-opacity = 0.9;
    };

    # Home Manager validates the Ghostty config on change, which fails while
    # the theme file doesn't exist yet (Noctalia only writes it once it runs).
    # Seed a writable placeholder; Noctalia overwrites it with its palette.
    # (lib.hm isn't in scope in a NixOS module, so this is
    # lib.hm.dag.entryBetween [ "onFilesChange" ] [ "linkGeneration" ] spelled out.)
    home.activation.seedGhosttyNoctaliaTheme = lib.mkIf ghostty {
      after = [ "linkGeneration" ];
      before = [ "onFilesChange" ];
      data = ''
        theme="''${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes/noctalia"
        if [ ! -e "$theme" ]; then
          run mkdir -p "$(dirname "$theme")"
          run install -m 644 ${pkgs.ghostty}/share/ghostty/themes/Adventure "$theme"
        fi
      '';
    };
  };
}
