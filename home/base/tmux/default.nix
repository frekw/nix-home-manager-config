{ pkgs, ... }:
{
  programs.tmux = {
    baseIndex = 1;
    clock24 = true;
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";
    shortcut = "a";
    extraConfig = (builtins.readFile ./tmux.conf);
    plugins = with pkgs; [
      tmuxPlugins.pain-control
      tmuxPlugins.prefix-highlight
      tmuxPlugins.sensible
      tmuxPlugins.weather
      tmuxPlugins.yank
    ];
  };
}
