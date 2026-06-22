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
    package = pkgs.unstable.claude-code;

    # plugins = [
    #   pkgs.fetchFromGitHub
    #   {
    #     owner = "obra";
    #     repo = "superpowers";
    #     rev = "8cf39006140a743dce31ba4046fceab90cc214e6";
    #     sha256 = "228fdd7e5908ea1d2f65218ecd9c71e1eefa0834d200d55fbb8bf8b5563acec0";
    #   }
    # ];

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
