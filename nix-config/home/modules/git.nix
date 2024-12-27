{ userConfig, ... }: {
  # Install git via home-manager module
  programs.git = {
    enable = true;
  };
}
