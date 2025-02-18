{pkgs, ...}: {
  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
  ];
}
