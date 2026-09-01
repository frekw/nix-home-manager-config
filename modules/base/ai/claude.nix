{
  config,
  lib,
  pkgs,
  agenix,
  ...
}:
let
  # Skills vendored from github.com/cursor/plugins (pstack). See claude-skills/VENDOR.md.
  claudeSkills = ./claude-skills;
in
{

  imports = [
    agenix.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    github-mcp-server
    mcp-grafana
  ];

  age.secrets.grafana-token.file = ../../../secrets/grafana-token.age;

  programs.zsh = {
    initContent = ''
      export GRAFANA_TOKEN=$(${pkgs.coreutils}/bin/cat ${config.age.secrets.grafana-token.path})
    '';
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.unstable.claude-code;

    plugins = [
      (pkgs.fetchFromGitHub {
        owner = "obra";
        repo = "superpowers";
        rev = "896224c4b1879920ab573417e68fd51d2ccc9072"; # v6.0.3
        hash = "sha256-+lT2a/qq0SF4k0PgnEDKiuidVlZX2p0vEso4d/5T1os=";
      })
    ];

    # Every directory under ./claude-skills becomes ~/.claude/skills/<name>/.
    skills = lib.mapAttrs (name: _: claudeSkills + "/${name}") (
      lib.filterAttrs (_: type: type == "directory") (builtins.readDir claudeSkills)
    );

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
        type = "http";
        url = "https://beat-mcp.staging.soundtr.ac/mcp";
      };
      linear = {
        type = "http";
        url = "https://mcp.linear.app/mcp";
      };
      javadocs = {
        type = "http";
        url = "https://www.javadocs.dev/mcp";
      };
      context7 = {
        type = "http";
        url = "https://mcp.context7.com/mcp";
      };
    };
  };
}
