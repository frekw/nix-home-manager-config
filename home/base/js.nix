{pkgs, ...}: {
  packages = with pkgs; [
    bun
    deno
    nodejs_latest
  ];
}