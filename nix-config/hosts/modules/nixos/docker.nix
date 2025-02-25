{
  pkgs,
  userConfig,
  ...
}: {
  # Docker configuration
  virtualisation.docker.enable = true;
  # virtualisation.docker.rootless.enable = true;
  # virtualisation.docker.rootless.setSocketVariable = true;
  users.users.${userConfig.name}.extraGroups = ["docker"];

  environment.systemPackages = with pkgs; [
    arion
    lazydocker
  ];
}
