{
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      tfctl = final.callPackage ./tfctl { };
      adr = final.callPackage ./adr { };
      app-launcher = final.callPackage ./app-launcher { };
      kube-context-switch = final.callPackage ./kube-context-switch { };
      monaspace = final.callPackage ./monaspace { };
      pants = final.callPackage ./pants { };
      sloth = final.callPackage ./sloth { };
      syb-cli = final.callPackage ./syb-cli { };

      darwinPackages = {
        altair = final.callPackage ./darwin/altair { };
        firefox = final.callPackage ./darwin/firefox { };
        obsidian = final.callPackage ./darwin/obsidian { };
        tunnelblick = final.callPackage ./darwin/tunnelblick { };
        vlc = final.callPackage ./darwin/vlc { };
        wombat = final.callPackage ./darwin/wombat { };
      };
    })
  ];
}
