{
  pkgs,
  lib,
  config,
  agenix,
  user,
  ...
}:
{
  options.modules.env = {
    ai = {
      enable = lib.mkEnableOption "AI tools";
    };
  };

  config = lib.mkIf config.modules.env.ai.enable {
    environment.systemPackages = with pkgs; [
      antigravity
      gemini-cli
      opencode
    ];

    home-manager.users.${user.username} = {
      imports = [
        agenix.homeManagerModules.default
      ];

      config = {
        home.file.".config/opencode/opencode.json".text = builtins.toJSON {
          "$schema" = "https://opencode.ai/config.json";
          plugin = [
            "opencode-gemini-auth@latest"
            "superpowers@git+https://github.com/obra/superpowers.git"
          ];
          mcp = { };
          provider = {
            google = {
              options = {
                #   projectId = "syb-production-agentspace";
                apiKey = "{env:GEMINI_API_KEY}";
              };
            };
          };
        };

        age = {
          secrets.geminiKey = {
            file = ../../../secrets/ai/gemini.age;
            path = "\${HOME}/.config/opencode/gemini_key";
            symlink = false;
          };
        };

        programs.zsh = {
          initContent = ''
            export GEMINI_API_KEY=$(${pkgs.coreutils}/bin/cat ${
              config.home-manager.users.${user.username}.age.secrets.geminiKey.path
            })
          '';
        };
      };
    };
  };
}
