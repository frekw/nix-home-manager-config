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
    zsh = {
      enable = lib.mkEnableOption "zsh";
      hostname-in-prompt = lib.mkEnableOption "hostname-in-prompt";
    };
  };

  config =
    {
      modules.programs.zsh.enable = lib.mkDefault true;
    }
    // lib.mkIf config.modules.programs.zsh.enable {
      home-manager.users.${user.username} = {
        programs.bat = {
          enable = true;
        };

        programs.eza = {
          enable = true;
          enableZshIntegration = true;
        };

        programs.fzf = {
          enable = true;
          enableZshIntegration = true;
        };

        programs.zsh = {
          defaultKeymap = "viins";
          enable = true;
          shellAliases = {
            ".." = "cd ..";
            grep = "grep --color=auto";
            kc = "kubectl";
            diff = "diff --color=auto";
            szsh = "source ~/.zshrc";
            cat = "bat";
            garbage = "nix-collect-garbage";
            reload = "switch && garbage";
            current-commit = ''
              git log -1 --pretty=format:'%h' | tr -d '
              ' | pbcopy'';
            lock = "pmset displaysleepnow";
            "nix-sha256" = "nix-hash --to-base32 --type sha256";
          };
          autosuggestion.enable = true;
          enableCompletion = true;
          autocd = false;
          history = {
            save = 50000;
            size = 50000;
            share = true;
          };
          initContent = builtins.concatStringsSep "\n" [
            (builtins.readFile ./scripts/init.sh)
            (
              if config.modules.programs.zsh.hostname-in-prompt then
                ''
                  setopt PROMPT_SUBST
                  export PROMPT='%F{blue}[%m] %F{white}%2~ %(?.%F{green}.%F{red})→%f '
                  export RPROMPT=
                ''
              else
                ''
                  setopt PROMPT_SUBST
                  export PROMPT='%F{white}%2~ %(?.%F{green}.%F{red})→%f '
                  export RPROMPT=
                ''
            )
          ];

          profileExtra = ''
            idconvert() {
              syb -env production idconvert $1
            }
          '';

          plugins = [
            {
              name = "zsh-autosuggestions";
              src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "v0.6.4";
                sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
              };
            }
            {
              name = "wting";
              src = pkgs.fetchFromGitHub {
                owner = "wting";
                repo = "autojump";
                rev = "release-v22.5.3";
                sha256 = "1rgpsh70manr2dydna9da4x7p8ahii7dgdgwir5fka340n1wrcws";
              };
            }
          ];
        };
      };
    };
}
