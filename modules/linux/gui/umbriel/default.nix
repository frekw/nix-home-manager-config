{
  lib,
  config,
  pkgs,
  user,
  umbriel,
  noctalia,
  noctalia-greeter,
  ...
}:
let
  cfg = config.modules.desktop.umbriel;
in
{
  options.modules.desktop.umbriel = {
    enable = lib.mkEnableOption "Umbriel compositor with the Noctalia shell";

    greeter.enable = lib.mkOption {
      type = lib.types.bool;
      # cosmic-greeter already drives greetd and lists the Umbriel session,
      # so only take over the login screen when COSMIC is off.
      default = !config.modules.desktop.cosmic.enable;
      defaultText = lib.literalExpression "!config.modules.desktop.cosmic.enable";
      description = "Use Noctalia Greeter (greetd) as the login screen.";
    };

    layout = lib.mkOption {
      type = lib.types.enum [
        "dwindle"
        "scrolling"
        "master"
        "stacking"
      ];
      # "dwindle" is the closest match to COSMIC's autotiling.
      default = "scrolling";
      description = "Default Umbriel layout for new workspaces.";
    };

    # Defaults carried over from the old COSMIC xkb_config.
    keyboard = {
      layout = lib.mkOption {
        type = lib.types.str;
        default = "se";
      };
      variant = lib.mkOption {
        type = lib.types.str;
        default = "us";
      };
      options = lib.mkOption {
        type = lib.types.str;
        default = "terminate:ctrl_alt_bksp,lv3:lalt_switch,caps:escape";
      };
    };

    # Window open/close animations from community-umbriel-shaders, by
    # directory name under animation/ (e.g. "glitch", "tv-glitch",
    # "kzzzt-open"/"kzzzt-close"). null keeps Umbriel's default animation.
    windowAnimation = {
      open = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "glitch";
      };
      close = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = "glitch";
      };
      duration = lib.mkOption {
        type = lib.types.ints.positive;
        default = 250;
        description = "Open/close animation length in milliseconds.";
      };
    };

    terminal = lib.mkOption {
      type = lib.types.str;
      default = "ghostty";
      description = "Command spawned by Mod+T / Mod+Return.";
    };

    browser = lib.mkOption {
      type = lib.types.str;
      default = "firefox";
      description = "Command spawned by Mod+B.";
    };

    fileManager = lib.mkOption {
      type = lib.types.str;
      default = "nautilus --new-window";
      description = "Command spawned by Mod+F.";
    };
  };

  imports = [
    umbriel.nixosModules.default
    noctalia.nixosModules.default
    noctalia-greeter.nixosModules.default
    ./home.nix
  ];

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        modules.desktop.wayland.clipboard.enable = true;

        nix.settings = {
          extra-substituters = [
            "https://umbriel.cachix.org"
            "https://noctalia.cachix.org"
          ];
          extra-trusted-public-keys = [
            "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          ];
        };

        # Registers the session, enables graphics and xdg-desktop-portal-umbriel.
        programs.umbriel.enable = true;

        # Noctalia is started from Umbriel's autostart (see home.nix), not systemd.
        programs.noctalia = {
          enable = true;
          # NetworkManager, Bluetooth, UPower and power-profiles-daemon.
          recommendedServices.enable = true;
        };

        xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

        # Secret Service for browsers, 1Password, Noctalia's calendar, etc.
        services.gnome.gnome-keyring.enable = lib.mkDefault true;
        programs.dconf.enable = true;
        # Spacebar quick-preview in Nautilus.
        services.gnome.sushi.enable = true;

        environment.systemPackages = with pkgs; [
          # Umbriel spawns Xwayland on demand and expects it on PATH.
          xwayland
          nautilus
          adwaita-icon-theme
        ];

        # disable screen reader
        services.orca.enable = false;
      }

      (lib.mkIf cfg.greeter.enable {
        services.displayManager.noctalia-greeter = {
          enable = true;
          # Lets Noctalia push its wallpaper/palette to the greeter without a password prompt.
          passwordless-sync-users = [ user.username ];
          settings = {
            session.default = "Umbriel";
            user.default = user.username;
            appearance.theme_mode = "dark";
            keyboard = {
              inherit (cfg.keyboard) layout variant options;
            };
          };
        };

        security.pam.services.greetd.enableGnomeKeyring = true;

        # greetd owns display-manager.service.
        services.displayManager.gdm.enable = lib.mkForce false;
      })
    ]
  );
}
