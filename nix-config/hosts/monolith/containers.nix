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
        "openldap".service = {
          container_name = "openldap";
          image = "docker.io/osixia/openldap:1.5.0";
          ports = ["389:389"];
          environment = {
            LDAP_TLS = "false";
            LDAP_OPENLDAP_UID = "351";
            LDAP_OPENLDAP_GID = "351";
            LDAP_ORGANISATION = "meskill-farmhouse";
            LDAP_DOMAIN = "meskill-farmhouse.lan";
          };
          networks = [
            "datanet"
            "hostnet"
          ];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/openldap/ldap:/var/lib/ldap"
            "/data/docker/openldap/slapd:/etc/ldap/slapd.d"
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
        "weatherflow".service = {
          container_name = "weatherflow";
          image = "docker.io/briis/weatherflow2mqtt:latest";
          ports = ["50222:50222/udp"];
          env_file = [config.age.secrets.monolith_docker_env_weatherflow.path];
          networks = [
            "hostnet"
          ];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/weatherflow/config:/usr/local/config"
          ];
        };
        "apprise".service = {
          container_name = "apprise";
          image = "lscr.io/linuxserver/apprise-api:latest";
          environment = {
            TZ = "America/Phoenix";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/apprise/config:/config"
          ];
        };
        "phpldapadmin".service = {
          container_name = "phpldapadmin";
          image = "docker.io/osixia/phpldapadmin:0.9.0";
          environment = {
            PHPLDAPADMIN_HTTPS = "false";
            PHPLDAPADMIN_LDAP_HOSTS = "#PYTHON2BASH:[{'openldap': [{'server': [{'tls': False}]},{'login': [{'bind_id': 'cn=admin,dc=meskill-farmhouse,dc=lan'}]}]}]";
          };
          networks = [
            "datanet"
            "proxynet"
          ];
          restart = "unless-stopped";
        };
        "bazarr".service = {
          container_name = "bazarr";
          image = "lscr.io/linuxserver/bazarr";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/bazarr/config:/config"
            "/nas/media/TV:/tv"
            "/nas/media/Kids/TV:/tv-kids"
            "/nas/media/Anime/TV:/tv-anime"
            "/nas/media/Movies:/movies"
            "/nas/media/Kids/Movies:/movies-kids"
            "/nas/media/Anime/Movies:/movies-anime"
            "/nas/media/Holidays:/movies-holidays"
          ];
        };
        "readarr".service = {
          container_name = "readarr";
          image = "lscr.io/linuxserver/readarr:develop";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/readarr/config:/config"
            "/nas/media/Books:/books"
            "/nas/media/xfer/completed:/data/xfer/completed"
          ];
        };
        "prowlarr".service = {
          container_name = "prowlarr";
          image = "lscr.io/linuxserver/prowlarr:develop";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/prowlarr/config:/config"
          ];
        };
        "sonarr".service = {
          container_name = "sonarr";
          image = "lscr.io/linuxserver/sonarr";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/sonarr/config:/config"
            "/nas/media/xfer/completed:/data/xfer/completed"
            "/nas/media/TV:/mnt/tv"
            "/nas/media/Kids/TV:/mnt/kids"
            "/nas/media/Anime/TV:/mnt/anime"
          ];
        };
        "radarr".service = {
          container_name = "radarr";
          image = "lscr.io/linuxserver/radarr";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/radarr/config:/config"
            "/nas/media/xfer/completed:/data/xfer/completed"
            "/nas/media/Movies:/mnt/movies"
            "/nas/media/Kids/Movies:/mnt/kids"
            "/nas/media/Anime/Movies:/mnt/anime"
            "/nas/media/Holidays:/mnt/holidays"
          ];
        };
        "jellyseerr".service = {
          container_name = "jellyseerr";
          image = "docker.io/fallenbagel/jellyseerr";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/jellyseerr/config:/app/config"
          ];
        };
        "autobrr".service = {
          container_name = "autobrr";
          image = "ghcr.io/autobrr/autobrr:latest";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/autobrr/config:/config"
          ];
        };
        "piavpn".service = {
          container_name = "piavpn";
          image = "docker.io/thrnz/docker-wireguard-pia";
          env_file = [config.age.secrets.monolith_docker_env_piavpn.path];
          ports = [
            "8080:8080"
            "8112:8112"
            "8191:8191"
            "6789:6789"
            "9999:9999"
          ];
          capabilities = {
            NET_ADMIN = true;
            NET_RAW = true;
            SYS_MODULE = true;
          };
          sysctls = {
            "net.ipv4.conf.all.src_valid_mark" = "1";
            "net.ipv6.conf.default.disable_ipv6" = "1";
            "net.ipv6.conf.all.disable_ipv6" = "1";
            "net.ipv6.conf.lo.disable_ipv6" = "1";
          };
          networks = ["hostnet"];
          restart = "unless-stopped";
          healthcheck = {
            test = [
              "CMD"
              "ping"
              "-c 1"
              "www.google.com"
              "||"
              "exit 1"
            ];
            interval = "30s";
            timeout = "30s";
            retries = 3;
          };
          volumes = [
            "/data/docker/piavpn/config:/config"
            "/data/docker/piavpn/shared:/pia-shared"
            "/lib/modules:/lib/modules"
          ];
        };
        "deluge".service = {
          container_name = "deluge";
          image = "lscr.io/linuxserver/deluge";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
            DELUGE_LOGLEVEL = "error";
          };
          network_mode = "service:piavpn";
          restart = "unless-stopped";
          depends_on = ["piavpn"];
          volumes = [
            "/data/docker/piavpn/shared:/pia"
            "/data/docker/deluge/config:/config"
            "/nas/media/xfer:/data/xfer"
          ];
        };
        "sabnzbd".service = {
          container_name = "sabnzbd";
          image = "lscr.io/linuxserver/sabnzbd";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          network_mode = "service:piavpn";
          restart = "unless-stopped";
          depends_on = ["piavpn"];
          volumes = [
            "/data/docker/sabnzbd/config:/config"
            "/nas/media/xfer:/data/xfer"
          ];
        };
        "flaresolverr".service = {
          container_name = "flaresolverr";
          image = "ghcr.io/flaresolverr/flaresolverr:latest";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
          };
          network_mode = "service:piavpn";
          restart = "unless-stopped";
          depends_on = ["piavpn"];
        };
        # "hbbs".service = {
        #   container_name = "hbbs";
        #   image = "docker.io/rustdesk/rustdesk-server:latest";
        #   environment = {
        #     ALWAYS_USE_RELAY = "Y";
        #   };
        #   depends_on = ["hbbr"];
        #   network_mode = "host";
        #   restart = "unless-stopped";
        #   volumes = [
        #     "/data/docker/hbbs/config:/root"
        #   ];
        # };
        # "hbbr".service = {
        #   container_name = "hbbr";
        #   image = "docker.io/rustdesk/rustdesk-server:latest";
        #   network_mode = "host";
        #   restart = "unless-stopped";
        #   volumes = [
        #     "/data/docker/hbbs/config:/root"
        #   ];
        # };
        "calibre".service = {
          container_name = "calibre";
          image = "lscr.io/linuxserver/calibre:latest";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            CALIBRE_TEMP_DIR = "/config/tmp";
            CALIBRE_CACHE_DIRECTORY = "/config/cache";
            AUTO_UPDATE = "false";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/calibre/config:/config"
            "/nas/media/Books:/mnt/calibre"
          ];
        };
        "calibre-automated".service = {
          container_name = "calibre-automated";
          image = "docker.io/crocodilestick/calibre-web-automated:latest";
          environment = {
            PUID = "4000";
            PGID = "4000";
            TZ = "America/Phoenix";
            AUTO_UPDATE = "false";
            #DOCKER_MODS = "lscr.io/linuxserver/mods:universal-calibre-v7.16.0";
          };
          networks = ["proxynet"];
          restart = "unless-stopped";
          volumes = [
            "/data/docker/calibre-automated/config:/config"
            "/nas/media/Books:/calibre-library"
            "/nas/media/xfer/ingest/calibre-automated:/cwa-book-ingest"
          ];
        };
        "frigate".service = {
          container_name = "frigate";
          image = "ghcr.io/blakeblackshear/frigate:stable";
          networks = ["proxynet"];
          restart = "unless-stopped";
          capabilities = {
            CAP_PERFMON = true;
          };
          tmpfs = ["/tmp/cache,size=2g"];
          volumes = [
            "/etc/localtime:/etc/localtime:ro"
            "/data/docker/frigate/config:/config"
            "/nas/media/xfer/frigate:/media/frigate"
          ];
          devices = [
            "/dev/apex_0:/dev/apex_0"
            "/dev/bus/usb:/dev/bus/usb"
            "/dev/dri/card0:/dev/dri/card0"
            "/dev/dri/renderD128:/dev/dri/renderD128"
          ];
        };
        "stepca".service = {
          container_name = "stepca";
          image = "docker.io/smallstep/step-ca";
          env_file = [config.age.secrets.monolith_docker_env_stepca.path];
          networks = ["proxynet"];
          restart = "unless-stopped";
          capabilities = {
            NET_ADMIN = true;
          };
          volumes = [
            "/data/docker/stepca/config:/home/step"
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
  age.secrets.monolith_docker_env_piavpn = {
    file = ./files/docker/env/piavpn.env.age;
    mode = "600";
  };
  age.secrets.monolith_docker_env_stepca = {
    file = ./files/docker/env/stepca.env.age;
    mode = "600";
  };
  age.secrets.monolith_docker_env_romm = {
    file = ./files/docker/env/romm.env.age;
    mode = "600";
  };
  age.secrets.monolith_docker_env_weatherflow = {
    file = ./files/docker/env/weatherflow.env.age;
    mode = "600";
  };
}
