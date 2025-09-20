{
  pkgs,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [80 443];

  age.secrets.caddy_env = {
    file = ./files/caddy/caddy.env.age;
    mode = "600";
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.1"];
      hash = "sha256-j+xUy8OAjEo+bdMOkQ1kVqDnEkzKGTBIbMDVL7YDwDY=";
    };
    environmentFile = config.age.secrets.caddy_env.path;
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_API_TOKEN}
      servers {
        protocols h1
      }
    '';
    virtualHosts."ai.svc.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy http://localhost:8080
    '';
    virtualHosts."ollama.svc.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy http://localhost:11434 {
        header_up Host localhost
      }
    '';
  };
}
