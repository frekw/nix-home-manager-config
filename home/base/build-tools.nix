{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cmake
    gnumake
    ninja
  ];
}
