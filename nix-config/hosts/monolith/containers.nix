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
        # hostnet services
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
            "${config.age.secrets.monolith_caddy_caddyfile.path}:/etc/caddy/Caddyfile"
            "/data/docker/caddy/site:/srv"
            "/data/docker/caddy/data:/data"
            "/data/docker/caddy/config:/config"
          ];
        };
        # datanet services
        "mariadb".service = {
          container_name = "mariadb";
          image = "docker.io/mariadb:latest";
          env_file = [config.age.secrets.monolith_docker_env_mariadb.path];
          networks = ["datanet"];
          healthcheck = {
            test = [
              "CMD"
              "healthcheck.sh"
              "--connect"
              "--innodb_initialized"
            ];
            start_period = "10s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          volumes = [
            "/data/docker/mariadb/mysql:/var/lib/mysql"
          ];
        };
        # proxynet services
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
        "romm".service = {
          container_name = "romm";
          image = "docker.io/rommapp/romm:latest";
          env_file = [config.age.secrets.monolith_docker_env_romm.path];
          networks = [
            "proxynet"
            "datanet"
          ];
          healthcheck = {
            test = [
              "CMD"
              "curl"
              "--fail"
              "http://127.0.0.1:8080"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          volumes = [
            "/data/docker/romm/resources:/romm/resources"
            "/data/docker/romm/config:/romm/config"
            "/data/docker/romm/assets:/romm/assets"
            "/data/docker/romm/redis:/redis-data"
            "/nas/roms:/romm/library"
          ];
        };
        "kavita".service = {
          container_name = "kavita";
          image = "lscr.io/linuxserver/kavita:latest";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
          };
          networks = ["proxynet"];
          healthcheck = {
            test = [
              "CMD"
              "curl"
              "--fail"
              "http://127.0.0.1:5000"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          volumes = [
            "/data/docker/kavita/config:/config"
            "/nas/media/Books:/mnt/books"
          ];
        };
        "ersatztv".service = {
          container_name = "ersatztv";
          image = "docker.io/jasongdove/ersatztv:latest-vaapi";
          ports = ["8409:8409"];
          environment = {
            TZ = "America/Phoenix";
          };
          networks = [
            "hostnet"
            "proxynet"
          ];
          healthcheck = {
            test = [
              "CMD"
              "curl"
              "--fail"
              "http://127.0.0.1:8409"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          tmpfs = ["/transcode,size=4g"];
          volumes = [
            "/data/docker/ersatztv/config:/config"
            "/nas/media:/mnt/plex:ro"
          ];
          devices = [
            "/dev/dri/card0:/dev/dri/card0"
            "/dev/dri/renderD128:/dev/dri/renderD128"
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
