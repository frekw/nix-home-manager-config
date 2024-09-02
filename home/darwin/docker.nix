{ pkgs, mypkgs, ... }:
{
  home.packages = with pkgs; [
    mypkgs.darwin.vfkit # https://github.com/NixOS/nixpkgs/issues/306179
    podman
    podman-compose
    (pkgs.writeShellScriptBin "docker" "exec -a $0 ${podman}/bin/podman $@")
    (pkgs.writeShellScriptBin "docker-compose" "exec -a $0 ${podman-compose}/bin/podman-compose $@")
    qemu
    rancher
  ];
}
