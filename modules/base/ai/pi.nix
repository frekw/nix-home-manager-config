{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    github-mcp-server
    mcp-grafana
  ];

  home.file.".pi/agent/skills".source = ./claude-skills;

  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    defaultProvider = "google";
    defaultModel = "gemini-3.1-pro-preview";
    defaultThinkingLevel = "high";
    packages = [
      "npm:pi-mcp-adapter"
      "npm:pi-web-search"
      "npm:pi-vim"
      "npm:pi-plan"
    ];
  };

  home.file.".pi/agent/mcp.json".text = builtins.toJSON {
    mcpServers = {
      github = {
        command = "${pkgs.github-mcp-server}/bin/github-mcp-server";
        args = [
          "stdio"
          "--toolsets"
          "org,repos,issues,pull_requests"
        ];
        env = {
          GITHUB_PERSONAL_ACCESS_TOKEN = "\${GITHUB_TOKEN}";
        };
      };
      grafana = {
        command = "${pkgs.mcp-grafana}/bin/mcp-grafana";
        args = [
          "stdio"
        ];
        env = {
          GRAFANA_URL = "https://grafana.monitoring-us.infrastructure.production.internal.syb.sh";
          GRAFANA_SERVICE_ACCOUNT_TOKEN = "\${GRAFANA_TOKEN}";
        };
      };
      # beat static-app host MCP server (staging). WARP-only — the host resolves to
      # an internal VIP reachable solely over WARP; beat's own OAuth gates access.
      beat = {
        url = "https://beat-mcp.staging.soundtr.ac/mcp";
      };
      linear = {
        url = "https://mcp.linear.app/mcp";
      };
      javadocs = {
        url = "https://www.javadocs.dev/mcp";
      };
      context7 = {
        url = "https://mcp.context7.com/mcp";
      };
    };
  };

  home.file.".pi/agent/models.json".text = builtins.toJSON {
    providers = {
      google = {
        apiKey = "$GEMINI_API_KEY";
        models = [
          {
            id = "gemini-3.1-pro-preview";
            name = "Gemini 3.1 Pro Preview";
            reasoning = true;
            input = [
              "text"
              "image"
            ];
            contextWindow = 1048576;

            maxTokens = 65536;
            cost = {
              input = 2;
              output = 12;
              cacheRead = 0.2;
              cacheWrite = 0;
            };
          }
          {
            id = "gemini-3.8-flash";
            name = "Gemini 3.8 Flash";
            reasoning = true;
            input = [
              "text"
              "image"
            ];
            contextWindow = 1048576;

            maxTokens = 65536;
            cost = {
              input = 1.5;
              output = 7.5;
              cacheRead = 0.15;
              cacheWrite = 0;
            };
          }
        ];
        api = "google-generative-ai";
        baseUrl = "https://generativelanguage.googleapis.com/v1beta";
      };
    };
  };
}
