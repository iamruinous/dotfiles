{
  lib,
  pkgs,
  ...
}: {
  networking.firewall.allowedTCPPorts = [80 443];

  services.caddy = {
    enable = lib.mkDefault true;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.1"];
      hash = "sha256-j+xUy8OAjEo+bdMOkQ1kVqDnEkzKGTBIbMDVL7YDwDY=";
    };
    # environmentFile = config.age.secrets.caddy_env.path;
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_API_TOKEN}
    '';
    # virtualHosts."ai.svc.farmhouse.meskill.network".extraConfig = ''
    #   reverse_proxy http://localhost:8080
    # '';
  };
}
