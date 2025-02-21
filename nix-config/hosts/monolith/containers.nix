{...}: {
  virtualisation.arion = {
    backend = "docker";
    projects."monolith".settings.services = {
      "pinchflat".service = {
        image = "ghcr.io/kieraneglin/pinchflat:latest";
        ports = ["127.0.0.1:8945:8945"];
        restart = "unless-stopped";
        environment = {
          TZ = "America/Phoenix";
        };
        volumes = [
          "/data/docker/pinchflat/config:/config"
        ];
      };
      "caddy".service = {
        image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
        ports = [
          "80:80"
          "443:443"
          "443:443/udp"
        ];
        restart = "unless-stopped";
        capabilities = {
          NET_ADMIN = true;
        };
        volumes = [
          "/data/docker/caddy/Caddyfile:/etc/caddy/Caddyfile"
          "/data/docker/caddy/site:/srv"
          "/data/docker/caddy/data:/data"
          "/data/docker/caddy/config:/config"
        ];
      };
    };
  };
}
# pinchflat:
#   image: ghcr.io/kieraneglin/pinchflat:latest
#   environment:
#     # Set the timezone to your local timezone
#     - TZ=America/Phoenix
#   ports:
#     - '8945:8945'
#   volumes:
#     - /mnt/config/pinchflat:/config
#     - /mnt/downloads:/downloads
# caddy:
#      image: ghcr.io/caddybuilds/caddy-cloudflare:latest
#      restart: unless-stopped
#      cap_add:
#          - NET_ADMIN
#      ports:
#          - "80:80"
#          - "443:443"
#          - "443:443/udp"
#      volumes:
#          - /mnt/config/caddy/Caddyfile:/etc/caddy/Caddyfile
#          - /mnt/config/caddy/site:/srv
#          - /mnt/config/caddy/data:/data
#          - /mnt/config/caddy/config:/config

