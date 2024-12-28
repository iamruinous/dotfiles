{ ... }: {
  # Enable ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  environment.systemPackages = with pkgs; [
    open-webui
  ];
}
