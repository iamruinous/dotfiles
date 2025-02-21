{...}: {
  virtualisation.arion = {
    backend = "docker";
    projects = {
      "echo".settings.services."echo".service = {
        image = "hashicorp/http-echo";
        ports = ["5678:5678"];
        restart = "unless-stopped";
      };
    };
  };
}
