{ stdenv, lib, fetchFromGitHub, bash, makeWrapper }:
  stdenv.mkDerivation {
    pname = "adr";
    version = "b3279ba";
    src = fetchFromGitHub {
      owner = "npryce";
      repo = "adr-tools";
      rev = "b3279baf9be2207d1a4f4bbd608fd0b591c72aee";
      sha256 = "1gb6mkn33lwg962xlamzndcsjkdwa8w92588k6kndkz27qrfpbxj";
    };
    buildInputs = [ bash ];
    nativeBuildInputs = [ makeWrapper ];
    installPhase = ''
      mkdir -p $out/bin
      cp src/* $out/bin/
      wrapProgram $out/bin/adr \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-config \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-generate \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-help \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-init \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-link \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-list \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-new \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/adr-upgrade-repository \
        --prefix PATH : ${lib.makeBinPath [ bash ]}

      wrapProgram $out/bin/_adr_add_link \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_autocomplete \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_commands \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_dir \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_file \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_generate_graph \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_generate_toc \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_help \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_help_new \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_links \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_remove_status \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_status \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      wrapProgram $out/bin/_adr_title \
        --prefix PATH : ${lib.makeBinPath [ bash ]}
      '';

      postInstall = ''
        installShellCompletion \
        --zsh $out/bin/_adr_add_link \
        --zsh $out/bin/_adr_autocomplete \
        --zsh $out/bin/_adr_commands \
        --zsh $out/bin/_adr_dir \
        --zsh $out/bin/_adr_file \
        --zsh $out/bin/_adr_generate_graph \
        --zsh $out/bin/_adr_generate_toc \
        --zsh $out/bin/_adr_help \
        --zsh $out/bin/_adr_help_new \
        --zsh $out/bin/_adr_links \
        --zsh $out/bin/_adr_remove_status \
        --zsh $out/bin/_adr_status \
        --zsh $out/bin/_adr_title
      '';
  }
