{ pkgs, user, ... }:
{

  home.packages = with pkgs; [ github-mcp-server ];

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
          GITHUB_PERSONAL_ACCESS_TOKEN = "{env:GITHUB_TOKEN}";
        };
      };
    };
  };
}
