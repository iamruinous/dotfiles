{config, ...}: {
  virtualisation.arion = {
    backend = "docker";
    projects."monolith".settings = {
      networks = {
        "hostnet" = {
          name = "hostnet";
        };
        "proxynet" = {
          name = "proxynet";
          internal = true;
        };
        "datanet" = {
          name = "datanet";
          internal = true;
        };
      };
      services = {
        "pinchflat".service = {
          container_name = "pinchflat";
          image = "ghcr.io/kieraneglin/pinchflat:latest";
          environment = {
            TZ = "America/Phoenix";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/pinchflat/config:/config"
            "/nas/media/YT:/downloads"
          ];
        };
        "caddy".service = {
          container_name = "caddy";
          image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
          networks = [
            "hostnet"
            "proxynet"
          ];
          ports = [
            "80:80"
            "443:443"
            "443:443/udp"
          ];
          capabilities = {
            NET_ADMIN = true;
          };
          restart = "unless-stopped";
          volumes = [
            "${config.age.secrets.monolith_caddy_caddyfile.path}:/etc/caddy/Caddyfile"
            "/data/docker/caddy/site:/srv"
            "/data/docker/caddy/data:/data"
            "/data/docker/caddy/config:/config"
          ];
        };
        "mariadb".service = {
          container_name = "mariadb";
          image = "docker.io/mariadb:latest";
          env_file = [config.age.secrets.monolith_docker_env_mariadb.path];
          networks = ["datanet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/mariadb/mysql:/var/lib/mysql"
          ];
        };
        "romm".service = {
          container_name = "romm";
          image = "docker.io/rommapp/romm:latest";
          env_file = [config.age.secrets.monolith_docker_env_romm.path];
          networks = [
            "proxynet"
            "datanet"
          ];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/romm/resources:/romm/resources"
            "/data/docker/romm/config:/romm/config"
            "/data/docker/romm/assets:/romm/assets"
            "/data/docker/romm/redis:/redis-data"
            "/nas/roms:/romm/library"
          ];
        };
      };
    };
  };

  age.secrets.monolith_caddy_caddyfile = {
    file = ./files/caddy/Caddyfile.age;
    mode = "600";
  };
  age.secrets.monolith_docker_env_mariadb = {
    file = ./files/docker/env/mariadb.env.age;
    mode = "600";
  };
  age.secrets.monolith_docker_env_romm = {
    file = ./files/docker/env/romm.env.age;
    mode = "600";
  };
}
