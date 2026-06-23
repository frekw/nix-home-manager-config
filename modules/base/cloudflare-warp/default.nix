{
  lib,
  config,
  options,
  ...
}:
{
  options.modules.programs.cloudflare-warp = {
    enable = lib.mkEnableOption "Cloudflare WARP";
  };

  # Branch on option *declarations* (`options`), not `pkgs`: deciding config
  # structure from `pkgs` is circular (pkgs is built from config) and the
  # foreign platform's option key must be absent to avoid "does not exist".
  # `homebrew` is only declared on darwin; everything else here is NixOS.
  config = lib.mkIf config.modules.programs.cloudflare-warp.enable (
    if options ? homebrew then
      { homebrew.casks = [ "cloudflare-warp" ]; }
    else
      { services.cloudflare-warp.enable = true; }
  );
}
