{ pkgs ? import <nixpkgs> { } }: {
  adr = pkgs.callPackage ./adr { };
  kubent = pkgs.callPackage ./kubent { };
  monaspace = pkgs.callPackage ./monaspace { };
  pants = pkgs.callPackage ./pants { };
  sloth = pkgs.callPackage ./sloth { };
  syb-cli = pkgs.callPackage ./syb-cli { };

  darwin = {
    altair = pkgs.callPackage ./darwin/altair { };
    firefox = pkgs.callPackage ./darwin/firefox { };
    obsidian = pkgs.callPackage ./darwin/obsidian { };
    tunnelblick = pkgs.callPackage ./darwin/tunnelblick { };
    vlc = pkgs.callPackage ./darwin/vlc { };
    wombat = pkgs.callPackage ./darwin/wombat { };
  };
}
