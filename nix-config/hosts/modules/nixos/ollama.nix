{ ... }: {
  # Enable ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
