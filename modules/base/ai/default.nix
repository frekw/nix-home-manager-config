{
  pkgs,
  lib,
  config,
  agenix,
  user,
  ...
}:
{
  imports = [ ./ollama.nix ];

  options.modules.env = {
    ai = {
      enable = lib.mkEnableOption "AI tools";
      ollama.enable = lib.mkEnableOption "Local Ollama";
    };
  };

  config = lib.mkIf config.modules.env.ai.enable {
    environment.systemPackages = with pkgs.unstable; [
      antigravity
      gemini-cli
      opencode
    ];

    home-manager.users.${user.username} = {
      imports = [
        ./claude.nix
        ./opencode.nix
        ./pi.nix
      ];
    };
  };
}
