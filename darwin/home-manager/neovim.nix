{ vimPlugins }:

{
  enable = true;
  # Sets alias vim=nvim
  vimAlias = true;

  extraConfig = (builtins.readFile ./.vimrc);

  # Neovim plugins
  plugins = with vimPlugins; [
    ctrlp
    editorconfig-vim
    gruvbox
    nerdtree
    tabular
    vim-elixir
    vim-nix
    vim-markdown
  ];
}