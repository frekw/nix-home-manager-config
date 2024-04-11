{ mypkgs, pkgs, agenix, ... }: {
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
    ./ssh.nix
    ./wezterm.nix
  ];

  xdg = { enable = true; };

  programs.direnv = {
    enable = true;

    nix-direnv = { enable = true; };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.gh = { enable = true; };

  programs.go = { enable = true; };

  # programs.gpg = { enable = true; };

  programs.home-manager = { enable = true; };

  programs.java = { enable = true; };

  programs.opam = {
    enable = false;
    enableZshIntegration = true;
    package = pkgs.opam;
  };

  programs.sbt = { enable = true; };

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
    ripgrep
    ruby
    scala
    slack
    # mypkgs.syb-cli
    mypkgs.kube-context-switch
    tree
    yarn
    yq-go
    youtube-dl
    zlib
  ];
}
