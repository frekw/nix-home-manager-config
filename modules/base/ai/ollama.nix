{
  pkgs,
  lib,
  config,
  user,
  options,
  ...
}:
{
  config = lib.mkIf config.modules.env.ai.enable (
    lib.mkMerge [
      # services.ollama doesn't exist on Darwin
      (lib.optionalAttrs (options.services ? ollama) {
        services.ollama = {
          enable = true;
          package = pkgs.unstable.ollama;
          syncModels = true;
          loadModels = [
            "devstral-small-2:24b"
            "nemotron-3-nano:30b"
            "gpt-oss:20b"
            "qwen3-coder:30b"
          ];
        };
      })
      {
        environment.systemPackages = lib.optionals pkgs.stdenv.isDarwin [
          pkgs.unstable.ollama
        ];

        home-manager.users.${user.username} = {
          programs.zsh = {
            initContent = ''
              export OLLAMA_KEEP_ALIVE=0
            '';
          };
        };
      }
    ]
  );
}
