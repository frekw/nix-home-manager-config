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

        programs.carapace = {
          enable = true;
          enableNushellIntegration = false;
        };

        programs.nushell = {
          enable = true;
          settings = {
            edit_mode = "vi";
            show_banner = false;
          };
          extraEnv = ''
            # Fall back on other shells if Carapace doesn't have a native completion
            $env.CARAPACE_BRIDGES = 'zsh,fish,bash'
            # Prevent Carapace from throwing errors on unrecognized shorthand flags
            $env.CARAPACE_LENIENT = 1
          '';
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


              # Define the core Carapace completion engine
              let carapace_completer = {|spans: list<string>|
                carapace $spans.0 nushell ...$spans | from json
              }

              # Smart completer wrapper that expands aliases before running Carapace
              let external_completer = {|spans|
                let expanded_alias = (scope aliases | where name == $spans.0 | get -o 0 | get -o expansion)
                
                let spans = if $expanded_alias != null {
                  $spans | skip 1 | prepend ($expanded_alias | split row ' ')
                } else {
                  $spans
                }

                match $spans.0 {
                  _ => $carapace_completer
                } | do $in $spans
              }

              # Safely merge our new external completer into the existing Nushell config
              $env.config = (
                $env.config
                | upsert completions (
                    $env.config.completions? 
                    | default {} 
                    | merge {
                        external: {
                          enable: true
                          max_results: 100
                          completer: $external_completer
                        }
                      }
                  )
              )
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
