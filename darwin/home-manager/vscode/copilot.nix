{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "github";
    name = "copilot";
    version = "1.30.6165";
    sha256 = "193bvmp027lp2gabwg5zknq69lalk9di4y72pkik8gssk11373nr";
  };
  meta = { license = lib.licenses.unfree; };
}