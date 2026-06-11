{
  ...
}:
{
  home.file.".config/.pi/agent/models.json".text = builtins.toJSON {
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
        ];
        api = "google-generative-ai";
        baseUrl = "https://generativelanguage.googleapis.com/v1beta";
      };
    };
  };
}
