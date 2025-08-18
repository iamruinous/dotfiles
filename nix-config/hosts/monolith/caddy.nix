{
  pkgs,
  config,
  ...
}: {
  age.secrets.caddy_env = {
    file = ../../${config.networking.hostName}/files/caddy/caddy.env.age;
    mode = "600";
  };

  services.caddy = {
    enable = false;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/acmedns@v0.5.0"];
      hash = "sha256-sGfNoauwoDeT7Q+F+o6D/rucF5etJJn8YFUE7V/0dzk=";
    };
    environmentFile = config.age.secrets.caddy_env.path;
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_API_TOKEN}
    '';
    virtualHosts."adminer.svc.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy
    '';
  };
}
