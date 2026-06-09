{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bun
    # deno
    pnpm
    nodejs_latest
  ];
}
