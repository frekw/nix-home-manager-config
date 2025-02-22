{
  config,
  mypkgs,
  pkgs,
  agenix,
  roc,
  ...
}:
{
  imports = [
    ./neovim
    ./tmux
    ./vscode
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

  programs.go = {
    enable = true;
  };

  # programs.gpg = { enable = true; };

  programs.java = {
    enable = true;
  };
  # Fix JAVA_HOME for zsh
  programs.zsh = {
    initExtra = ''
      export JAVA_HOME="${config.home.sessionVariables.JAVA_HOME}"
    '';
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
    clang-tools
    elixir
    fd
    # ffmpeg
    ffmpeg_7
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
    postman
    ripgrep
    ruby
    scala
    slack
    mypkgs.syb-cli
    mypkgs.kube-context-switch
    # roc.packages."${pkgs.system}".default
    # roc.packages."${pkgs.system}".lang-server
    tree
    yarn
    yq-go
    yt-dlp
    zed-editor
    zlib
  ];
}
