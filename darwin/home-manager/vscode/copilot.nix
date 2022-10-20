{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "github";
    name = "copilot";
    version = "1.54.7077";
    sha256 = "sha256-IwBApJKMljJBXSddtoGUylmzvudv2GFQOXOwsXVI2rE=";
  };
  meta = { license = lib.licenses.unfree; };
}