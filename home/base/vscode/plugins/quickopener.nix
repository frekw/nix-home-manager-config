{ pkgs, lib, ... }:

pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "mogelbrod";
    name = "quickopener";
    version = "0.4.1";
    sha256 = "sha256-AJ3C1QdGpsobSMyu7xes+rC4EW/NravZWS60GqEKW2Y=";
  };
  meta = { license = lib.licenses.mit; };
}