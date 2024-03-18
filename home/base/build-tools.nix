{pkgs, ...}: {
  home.packages = with pkgs; [
    bazel
    buck2
    cmake
    ninja
  ];
}