{
  config,
  pkgs,
  agenix,
  ...
}:
{
  imports = [
    agenix.homeManagerModules.default
  ];

  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    plugin = [
      "opencode-gemini-auth@latest"
      "superpowers@git+https://github.com/obra/superpowers.git"
    ];
    mcp = { };

    # ollama pull qwen3-coder:30b
    # /set parameter num_ctx 32768
    # /save qwen3

    # ollama pull deepseek-r1:32b
    # /set parameter num_ctx 32768
    # /set parameter temperature 0.6
    # /save r1-32b-logic

    # ollama pull gpt-oss:20b
    # /set parameter num_ctx 32768
    # /set parameter temperature 0.1
    # /save gpt-oss-20b-build

    # to try: glm 4.7 flash
    # devstral 2
    # nemotron-cascade-2 <- should be good for building. use frotnier model for planning.
    # nemotron-3-Nano

    provider = {
      ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama Local";
        options = {
          baseURL = "http://localhost:11434/v1";
        };
        models = {
          qwen3 = {
            name = "qwen3-coder:30b (local)";
            id = "qwen3-coder:30b";
            tools = true;
          };

          devstral-2 = {
            name = "devstral-small-2:24b (local)";
            id = "devstral-small-2:24b";
            tools = true;
            options = {
              # temperature = 0.1;
              num_ctx = 64000;
              extraBody = {
                mode = "agentic";
                thinking_blocks = true;
                tools_protocol = "vibe-v1";
              };
            };
          };

          nemotron-3-nano = {
            name = "nemotro-3-nano:30b (local)";
            id = "nemotron-3-nano:30b";
            tools = true;
            options = {
              num_ctx = 131072;
              extraBody = {
                think = true;
                stop = [
                  "<|im_end|>"
                  "<|thought_end|>"
                ];
              };
            };
          };

          gpt-oss-20b = {
            name = "gpt-oss:20b (local)";
            id = "gpt-oss:20b";
            tools = true;
          };
        };
      };

      google = {
        options = {
          #   projectId = "syb-production-agentspace";
          apiKey = "{env:GEMINI_API_KEY}";
        };
      };
    };
    agent = {
      plan = {
        model = "ollama/nemotron-3-nano:30b";
        temperature = 0.7;
      };
      build = {
        model = "ollama/devstral-small-2:24b";
        temperature = 0.1;
      };
    };
  };

  age = {
    secrets.geminiKey = {
      file = ../../../secrets/ai/gemini.age;
      path = "\${HOME}/.config/opencode/gemini_key";
      symlink = false;
    };
  };

  programs.zsh = {
    initContent = ''
      export GEMINI_API_KEY=$(${pkgs.coreutils}/bin/cat ${config.age.secrets.geminiKey.path})
    '';
  };
}
