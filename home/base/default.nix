{mypkgs, ...}: {
  imports = [
    ./neovim
    ./tmux
    ./vscode
    ./zsh
    ./alacritty.nix
    ./build-tools.nix
    ./cloud.nix
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./js.nix
    ./ssh.nix
    ./wezterm.nix
  ];

  fonts. fontconfig = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    
    nix-direnv = {
      enable = true;
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.go = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.home-manager = {
    enable = true;
  };

  programs.java = {
    enable = true;
  };

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
    package = unstable.opam;
  };

  programs.sbt = {
    enable = true;
  };

  home.packages = with pkgs; [
    audacity
    bash
    bat
    clang-tools
    elixir
    fd
    ffmpeg
    gopls
    go-outline
    ginkgo
    graphviz
    grpcurl
    httpie
    jq
    keybase
    nixfmt
    python3
    reattach-to-user-namespace
    rectangle
    ripgrep
    rnix-lsp
    ruby
    scala
    slack
    mypkgs.syb-cli
    tree
    yarn
    yq-go
    youtube-dl
    zlib
  ];
}