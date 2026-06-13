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
    settings = {
      enabledPlugins = {
        "superpowers@claude-plugins-official" = true;
      };
    };
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
      linear = {
        type = "http";
        url = "https://mcp.linear.app/mcp";
      };
    };
  };
}
