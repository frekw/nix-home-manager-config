{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "mjmcloug";
    name = "vscode-elixir";
    version = "1.1.0";
    sha256 = "sha256-EE4x75ljGu212gqu1cADs8bsXLaToVaDnXHOqyDlR04=";
  };
  meta = { license = lib.licenses.unfree; };
}