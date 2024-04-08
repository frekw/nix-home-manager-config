{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    deno
    nodePackages_latest.pnpm
    nodejs_latest
  ];
}
