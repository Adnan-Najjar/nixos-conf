{ pkgs, ... }:
{

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # Run opencode with ollama
  # https://github.com/p-lemonish/ollama-x-opencode
  programs.opencode = {
    enable = true;
    settings = {
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models = {
            # /set parameter num_ctx 16384
            # /save qwen2.5-coder:0.5b-16k
            "qwen2.5-coder:0.5b-16k" = {
              name = "Qwen2.5 Coder 0.5b 16k";
              webfetch = true;
              tools = true;
              edit = "allow";
              bash = true;
              write = true;
              read = true;
              grep = true;
              glob = true;
              list = true;
              todowrite = true;
              todoread = true;
              patch = true;
            };
          };
        };
      };
    };
  };
}
