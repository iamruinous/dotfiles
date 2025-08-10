{config, ...}: {
  virtualisation.docker.storageDriver = "btrfs";

  virtualisation.arion = {
    backend = "docker";
    projects."monolith".settings = {
      networks = {
        "hostnet" = {
          name = "hostnet";
        };
        "proxynet" = {
          name = "proxynet";
        };
        "datanet" = {
          name = "datanet";
          internal = true;
        };
      };
      services = {
        # hostnet services
        "caddy".service = {
          container_name = "caddy";
          image = "ghcr.io/caddybuilds/caddy-cloudflare:2.10.0";
          networks = [
            "hostnet"
            "proxynet"
          ];
          ports = [
            "80:80"
            "443:443"
            "443:443/udp"
            "2019:2019"
          ];
          capabilities = {
            NET_ADMIN = true;
          };
          healthcheck = {
            test = [
              "CMD"
              "wget"
              "--no-verbose"
              "--tries=1"
              "--spider"
              "http://127.0.0.1:2019/metrics"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          volumes = [
            "${config.age.secrets.tty_ruinous_social_caddy_caddyfile.path}:/etc/caddy/Caddyfile"
            "/data/docker/caddy/site:/srv"
            "/data/docker/caddy/data:/data"
            "/data/docker/caddy/config:/config"
          ];
        };
        # datanet services
        # proxynet services
      };
    };
  };

  age.secrets.tty_ruinous_social_caddy_caddyfile = {
    file = ./files/caddy/Caddyfile.age;
    mode = "600";
  };
}
