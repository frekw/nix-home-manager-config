{
  pkgs,
  config,
  home-manager,
  user,
  lib,
  ...
}:
{
  options.modules.programs = {
    nushell = {
      enable = lib.mkEnableOption "nushell";
    };
  };

  config = lib.mkMerge [
    {
      modules.programs.nushell.enable = lib.mkDefault false;
    }
    (lib.mkIf config.modules.programs.nushell.enable {
      home-manager.users.${user.username} = {
        programs.bat = {
          enable = true;
        };

        programs.eza = {
          enable = true;
        };

        programs.nushell = {
          enable = true;
          settings = {
            edit_mode = "vi";
            show_banner = false;
          };
          extraConfig = lib.concatStringsSep "\n" [
            ''
              # Define the left prompt
              $env.PROMPT_COMMAND = { ||
                  let dir = ($env.PWD | str replace $nu.home-path "~" | path split | last 2 | path join)

                  let indicator_color = if $env.LAST_EXIT_CODE == 0 { 
                      (ansi green) 
                  } else { 
                      (ansi red) 
                  }

                  (ansi white) + $dir + " " + $indicator_color + "→" + (ansi reset) + " "
              }

              $env.PROMPT_COMMAND_RIGHT = { || "" }
              $env.PROMPT_INDICATOR = { || "" }
              $env.PROMPT_INDICATOR_VI_INSERT = { || "" }
              $env.PROMPT_INDICATOR_VI_NORMAL = { || "" }

              # Custom command for git commit hash
              def current-commit [] {
                git log -1 --pretty=format:'%h' | str trim | pbcopy
              }

              # You can also combine them into a 'reload' command if you like
              def nix-reload [] {
                nix-switch
                nix-collect-garbage
              }
            ''

            (
              if pkgs.stdenv.isDarwin then
                ''
                  def nix-switch [] {
                    darwin-rebuild build --flake ~/src/priv/nix-home-manager-config
                    sudo ./result/activate
                    rm -rf result
                  }
                ''
              else
                ''
                  def nix-switch [] {
                    sudo nixos-rebuild switch --flake ~/src/priv/nix-home-manager-config
                  }
                ''
            )
          ];
          shellAliases = {
            ".." = "cd ..";
            ll = "ls -l";
            grep = "grep --color=auto";
            kc = "kubectl";
            diff = "diff --color=auto";
            cat = "bat";
            lock = "pmset displaysleepnow";
            "nix-sha256" = "nix-hash --to-base32 --type sha256";
          };
        };
      };
    })
  ];
}
