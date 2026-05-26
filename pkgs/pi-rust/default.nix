{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  sqlite,
  makeWrapper,
  ripgrep,
  fd,
}:

rustPlatform.buildRustPackage rec {
  pname = "pi-coding-agent-rust";
  version = "0.1.15";

  src = fetchFromGitHub {
    owner = "Dicklesworthstone";
    repo = "pi_agent_rust";
    rev = "v${version}";
    # To get the hash: run `nix-prefetch-url --unpack https://github.com/Dicklesworthstone/pi_agent_rust/archive/v0.1.15.tar.gz`
    # Or just leave it as lib.fakeHash and let Nix tell you the correct one.
    hash = "sha256-YWPjDixPWDM7bzcEzIgkPTFBmLvk8e1DcFumTt8USWA=";
  };

  # This project includes a Cargo.lock, so we use it directly
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    sqlite
  ];

  # pi_agent_rust relies on ripgrep (rg) and fd-find (fd) for its tools.
  # We wrap the binary to ensure these are always in its PATH.
  postInstall = ''
    wrapProgram $out/bin/pi \
      --prefix PATH : ${
        lib.makeBinPath [
          ripgrep
          fd
        ]
      }
  '';

  meta = with lib; {
    description = "High-performance AI coding agent CLI written in Rust";
    homepage = "https://github.com/Dicklesworthstone/pi_agent_rust";
    license = licenses.mit;
    mainProgram = "pi";
  };
}
