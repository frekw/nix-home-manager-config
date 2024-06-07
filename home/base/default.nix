{
  mypkgs,
  pkgs,
  agenix,
  roc,
  ...
}:
{
  imports = [
    agenix.homeManagerModules.default
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
    ./kitty.nix
    ./rio.nix
    ./ssh.nix
    ./wezterm.nix
  ];

  xdg = {
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
    enableZshIntegration = true;
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

  # programs.gpg = { enable = true; };

  programs.home-manager = {
    enable = true;
  };

  programs.java = {
    enable = true;
  };

  programs.ncspot = {
    enable = true;
  };

  programs.opam = {
    enable = false;
    enableZshIntegration = true;
    package = pkgs.opam;
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
    nixfmt-rfc-style
    python3
    ripgrep
    ruby
    scala
    slack
    # mypkgs.syb-cli
    mypkgs.kube-context-switch
    # roc.packages."${pkgs.system}".default
    # roc.packages."${pkgs.system}".lang-server
    tree
    yarn
    yq-go
    youtube-dl
    # zed-editor
    zlib
  ];
}
