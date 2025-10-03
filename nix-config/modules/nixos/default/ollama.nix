{lib, ...}: {
  # Enable ollama
  services.ollama = {
    enable = lib.mkDefault true;
    acceleration = "cuda";
    loadModels = ["llama3.2:3b" "deepseek-r1:1.5b"];
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };

  services.open-webui = {
    enable = lib.mkDefault true;
  };
}
