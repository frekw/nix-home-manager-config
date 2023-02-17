{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "github";
    name = "copilot";
    version = "1.73.8685";
    sha256 = "sha256-MFFh3WRWWoFvIqpvLoB/E5ozyK/N7OysoMfaDNO7OqQ=";
  };
  meta = { license = lib.licenses.unfree; };
}