{config, ...}: {
  virtualisation.docker.storageDriver = "btrfs";

  virtualisation.arion = {
    backend = "docker";
    projects."tty-ruinous-social".settings = {
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
        # "mosquitto".service = {
        #   container_name = "mosquitto";
        #   image = "docker.io/eclipse-mosquitto:2";
        #   command = ["/usr/sbin/mosquitto" "-c" "/config/mosquitto.conf"];
        #   networks = ["hostnet"];
        #   ports = [
        #     "1883:1883"
        #   ];
        #   restart = "unless-stopped";
        #   volumes = [
        #     "${config.age.secrets.tty_ruinous_social_mosquitto_config.path}:/config/mosquitto.conf:ro"
        #     "/data/docker/mosquitto/config:/config"
        #     "/data/docker/mosquitto/data:/mosquitto/data"
        #     "/data/docker/mosquitto/log:/mosquitto/log"
        #   ];
        # };
        # datanet services
        "postgres".service = {
          container_name = "postgres";
          image = "docker.io/postgres:17";
          ports = ["5432:5432"];
          environment = {
            PGDATA = "/var/lib/postgresql/17/docker";
          };
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_postgres.path];
          networks = ["datanet" "hostnet"];
          healthcheck = {
            test = [
              "CMD-SHELL"
              "pg_isready"
            ];
            start_period = "10s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          volumes = [
            "/data/docker/postgres/pgdata:/var/lib/postgresql/17/docker"
          ];
        };
        "redis".service = {
          container_name = "redis";
          image = "docker.io/redis:8-alpine";
          networks = ["datanet"];
          healthcheck = {
            test = [
              "CMD"
              "redis-cli"
              "ping"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          restart = "unless-stopped";
          volumes = [
            "/data/docker/redis/data:/data"
          ];
        };
        # proxynet services
        "albyhub".service = {
          container_name = "albyhub";
          image = "ghcr.io/getalby/hub:latest";
          environment = {
            WORK_DIR = "/data/albyhub";
            TZ = "America/Phoenix";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/albyhub/data:/data"
          ];
        };
        "forgejo".service = {
          container_name = "forgejo";
          image = "codeberg.org/forgejo/forgejo:12";
          environment = {
            USER_UID = "2000";
            USER_GID = "2000";
          };
          networks = ["hostnet" "datanet" "proxynet"];
          restart = "unless-stopped";
          ports = [
            "127.0.0.1:2222:22"
          ];
          volumes = [
            "/data/docker/forgejo/data:/data"
            "/home/git/.ssh:/data/git/.ssh"
            "/home/git/.gnupg:/data/git/.gnupg"
            "/etc/timezone:/etc/timezone:ro"
            "/etc/localtime:/etc/localtime:ro"
          ];
        };
        "karakeep".service = {
          container_name = "karakeep";
          image = "ghcr.io/karakeep-app/karakeep:release";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_karakeep.path];
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/karakeep/data:/data"
          ];
        };
        "karakeep-chrome".service = {
          container_name = "karakeep-chrome";
          image = "gcr.io/zenika-hub/alpine-chrome:124";
          networks = ["proxynet"];
          restart = "unless-stopped";
          command = [
            "--no-sandbox"
            "--disable-gpu"
            "--disable-dev-shm-usage"
            "--remote-debugging-address=0.0.0.0"
            "--remote-debugging-port=9222"
            "--hide-scrollbars"
          ];
        };
        "karakeep-meilisearch".service = {
          container_name = "karakeep-meilisearch";
          image = "docker.io/getmeili/meilisearch:v1.13.3";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_karakeep.path];
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/karakeep/meili_data:/meili_data"
          ];
        };
        # "linkstack".service = {
        #   container_name = "linkstack";
        #   image = "docker.io/linkstackorg/linkstack:latest";
        #   environment = {
        #     HTTP_SERVER_NAME = "links.ruinous.social";
        #     HTTPS_SERVER_NAME = "links.ruinous.social";
        #     LOG_LEVEL = "debug";
        #     SERVER_ADMIN = "iamruinous@ruinous.social";
        #     TZ = "America/Phoenix";
        #   };
        #   networks = ["datanet" "proxynet"];
        #   restart = "unless-stopped";
        #   volumes = [
        #     "/data/docker/linkstack/.env:/htdocs/.env:rw"
        #     "/data/docker/linkstack/config/advanced-config.php:/htdocs/config/advanced-config.php:rw"
        #     "/data/docker/linkstack/img:/htdocs/img:rw"
        #     "/data/docker/linkstack/database:/htdocs/database:rw"
        #   ];
        # };
        "mastodon-sidekiq".service = {
          container_name = "mastodon-sidekiq";
          image = "ghcr.io/mastodon/mastodon:v4.4";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_mastodon.path];
          networks = ["datanet" "proxynet"];
          restart = "unless-stopped";
          command = [
            "bundle"
            "exec"
            "sidekiq"
          ];
          healthcheck = {
            test = [
              "CMD-SHELL"
              "ps aux | grep '[s]idekiq\ 7' || false"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          volumes = [
            "/data/docker/mastodon/public/system:/mastodon/public/system"
          ];
        };
        "mastodon-streaming".service = {
          container_name = "mastodon-streaming";
          image = "ghcr.io/mastodon/mastodon-streaming:v4.4";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_mastodon.path];
          networks = ["datanet" "proxynet"];
          restart = "unless-stopped";
          command = [
            "node"
            "./streaming/index.js"
          ];
          healthcheck = {
            test = [
              "CMD-SHELL"
              "curl -s --noproxy localhost localhost:4000/api/v1/streaming/health | grep -q 'OK' || exit 1"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
        };
        "mastodon-web".service = {
          container_name = "mastodon-web";
          image = "ghcr.io/mastodon/mastodon:v4.4";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_mastodon.path];
          networks = ["datanet" "proxynet"];
          restart = "unless-stopped";
          command = [
            "bundle"
            "exec"
            "puma"
            "-C"
            "config/puma.rb"
          ];
          healthcheck = {
            test = [
              "CMD-SHELL"
              "curl -s --noproxy localhost localhost:3000/health | grep -q 'OK' || exit 1"
            ];
            start_period = "60s";
            interval = "60s";
            timeout = "5s";
            retries = 3;
          };
          volumes = [
            "/data/docker/mastodon/public/system:/mastodon/public/system"
          ];
        };
        "mealie".service = {
          container_name = "mealie";
          image = "ghcr.io/mealie-recipes/mealie:latest";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_mealie.path];
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/mealie/data:/app/data"
          ];
        };
        "synapse".service = {
          container_name = "synapse";
          image = "ghcr.io/element-hq/synapse:latest";
          env_file = [config.age.secrets.tty_ruinous_social_docker_env_synapse.path];
          networks = ["datanet" "proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/synapse/data:/data"
          ];
        };
        "synapse-maubot".service = {
          container_name = "maubot";
          image = "dock.mau.dev/maubot/maubot:latest";
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/maubot/data:/data"
          ];
        };
        "writefreely".service = {
          container_name = "writefreely";
          image = "docker.io/writeas/writefreely:latest";
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/writefreely/keys:/go/keys"
            "/data/docker/writefreely/db:/db"
            "/data/docker/writefreely/config.ini:/go/config.ini"
          ];
        };
      };
    };
  };

  age.secrets.tty_ruinous_social_caddy_caddyfile = {
    file = ./files/caddy/Caddyfile.age;
    mode = "600";
  };
  # mosquitto container chowns the file
  age.secrets.tty_ruinous_social_mosquitto_config = {
    file = ./files/mosquitto/mosquitto.conf.age;
    path = "/data/docker/mosquitto/config/mosquitto.conf";
    mode = "600";
    owner = "1883";
    group = "1883";
    symlink = false;
  };
  age.secrets.tty_ruinous_social_docker_env_karakeep = {
    file = ./files/docker/env/karakeep.env.age;
    mode = "600";
  };
  age.secrets.tty_ruinous_social_docker_env_mastodon = {
    file = ./files/docker/env/mastodon.env.age;
    mode = "600";
  };
  age.secrets.tty_ruinous_social_docker_env_mealie = {
    file = ./files/docker/env/mealie.env.age;
    mode = "600";
  };
  age.secrets.tty_ruinous_social_docker_env_postgres = {
    file = ./files/docker/env/postgres.env.age;
    mode = "600";
  };
  age.secrets.tty_ruinous_social_docker_env_synapse = {
    file = ./files/docker/env/synapse.env.age;
    mode = "600";
  };
}
