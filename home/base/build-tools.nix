{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # bazel
    buck2
    cmake
    gnumake
    ninja
  ];
}
