{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "github";
    name = "copilot";
    version = "1.25.6056";
    sha256 = "05ls3lxjadwdncddjwvqwv2m6s3l6l4p2l7kvlxrsafq888sh1gl";
  };
  meta = { license = lib.licenses.unfree; };
}