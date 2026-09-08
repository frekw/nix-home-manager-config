{
  agenix,
  pkgs,
  config,
  lib,
  user,
  ...
}:
{
  options.modules.dev = {
    github = {
      enable = lib.mkEnableOption "github";
    };
  };

  config = lib.mkIf config.modules.dev.github.enable {
    modules.programs.zsh.enable = true;

    home-manager.users.${user.username} = {
      imports = [
        agenix.homeManagerModules.default
      ];

      age.secrets.github-token.file = ../../../secrets/github-token.age;

      programs.gh = {
        enable = true;
        settings = {
          aliases = {
            release-next = ''!sh -c '
              latest=$(gh release view --json tagName --jq .tagName 2>/dev/null)
              if [ -z "$latest" ]; then
                latest=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
              fi

              case "$latest" in
                v*) prefix="v"; ver="''${latest#v}" ;;
                *)  prefix="";  ver="$latest" ;;
              esac

              ver="''${ver%%-*}"
              major=$(echo "$ver" | cut -d. -f1)
              minor=$(echo "$ver" | cut -d. -f2)
              major=''${major:-0}
              minor=''${minor:-0}

              next_minor=$((minor + 1))
              next_version="''${prefix}''${major}.''${next_minor}.0"

              echo "Releasing ''$next_version (previous: ''$latest)..."
              gh release create "''$next_version" --title "''$next_version" --generate-notes "$@"
            ' --'';
          };
        };
      };

      programs.zsh = {
        initContent = ''
          export GITHUB_TOKEN=$(${pkgs.coreutils}/bin/cat ${
            config.home-manager.users.${user.username}.age.secrets.github-token.path
          })
        '';
      };

      programs.nushell = {
        extraConfig = ''
          try {
            let secret_path = "${config.home-manager.users.${user.username}.age.secrets.github-token.path}"
            if($secret_path | path exists) {
              let token = (open $secret_path | str trim)
              load-env { GITHUB_TOKEN: $token }
            }
          }
        '';
      };
    };
  };
}
