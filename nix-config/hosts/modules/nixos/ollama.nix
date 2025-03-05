{
  pkgs,
  config,
  ...
}: {
  # Enable ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = true;
  };

  age.secrets.caddy_env = {
    file = ../../${config.networking.hostName}/files/caddy/caddy.env.age;
    mode = "600";
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e"];
      hash = "sha256-jCcSzenewQiW897GFHF9WAcVkGaS/oUu63crJu7AyyQ=";
    };
    environmentFile = config.age.secrets.caddy_env.path;
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_API_TOKEN}
    '';
    virtualHosts."ai.svc.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy http://localhost:8080 {
        header_down X-Real-IP {http.request.remote}
        header_down X-Forwarded-For {http.request.remote}
      }
    '';
    virtualHosts."ollama.svc.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy http://localhost:11434 {
        header_down X-Real-IP {http.request.remote}
        header_down X-Forwarded-For {http.request.remote}
      }
    '';
  };
  networking.firewall.allowedTCPPorts = [80 443];
}
