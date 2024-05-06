{ pkgs, ... }:
{

  home.packages = [ pkgs.wl-clipboard ];
  programs.zsh.shellAliases = {
    pbcopy = "wl-copy";
    pbpaste = "wl-paste";
  };
}
