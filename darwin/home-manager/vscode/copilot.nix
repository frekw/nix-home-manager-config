{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "github";
    name = "copilot";
    version = "1.73.8685";
    sha256 = "sha256-W1j1VAuSM1sgxHRIahqVncUlknT+MPi7uutY+0NURZQ=";
  };
  meta = { license = lib.licenses.unfree; };
}