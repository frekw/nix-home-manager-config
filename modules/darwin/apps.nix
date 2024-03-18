{ config, lib, pkgs, ... }: {
  environment.variables = {
    # Fix https://github.com/LnL7/nix-darwin/wiki/Terminfo-issues
    TERMINFO_DIRS =
      map (path: path + "/share/terminfo") config.environment.profiles
      ++ [ "/usr/share/terminfo" ];

    EDITOR = "nvim";
  };

  # Set environment variables for nix-darwin before run `brew bundle`.
  system.activationScripts.homebrew.text = lib.mkBefore ''
    echo >&2 '${homebrew_env_script}'
    ${homebrew_env_script}
  '';
}
