{ pkgs }:

{
  enable = true;
  clock24 = true;
  escapeTime = 0;
  baseIndex = 1;
  keyMode = "vi";
  shortcut = "a";
  extraConfig = (builtins.readFile ./tmux.conf);
  plugins = with pkgs; [
    tmuxPlugins.pain-control
    tmuxPlugins.prefix-highlight
    tmuxPlugins.sensible
    tmuxPlugins.weather
    tmuxPlugins.yank
  ];
}