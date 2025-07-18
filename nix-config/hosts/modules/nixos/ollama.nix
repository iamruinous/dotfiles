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

  # services.open-webui = {
  #   enable = true;
  # };

  age.secrets.caddy_env = {
    file = ../../${config.networking.hostName}/files/caddy/caddy.env.age;
    mode = "600";
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.1"];
      hash = "sha256-2D7dnG50CwtCho+U+iHmSj2w14zllQXPjmTHr6lJZ/A=";
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
