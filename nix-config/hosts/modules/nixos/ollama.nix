{ pkgs, ... }: {
  # Enable ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  services.open-webui = {
    enable = true;
  };

  age.secrets.caddy_root_ca = {
    file = ../../../files/configs/caddy/root_ca.crt.age;
    path = "/etc/caddy/root_ca.crt";
    mode = "600";
  };

  services.caddy = {
    enable = true;
    acmeCA = "https://ca.svc.farmhouse.meskill.network/acme/acme/directory";
    globalConfig = ''
      acme_ca_root /etc/caddy/root_ca.crt
    '';
    virtualHosts."ai.svc.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy http://localhost:8080 {
        header_down X-Real-IP {http.request.remote}
        header_down X-Forwarded-For {http.request.remote}
      }
    '';
    virtualHosts."obelisk.manage.farmhouse.meskill.network".extraConfig = ''
      reverse_proxy http://localhost:8080 {
        header_down X-Real-IP {http.request.remote}
        header_down X-Forwarded-For {http.request.remote}
      }
    '';
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
