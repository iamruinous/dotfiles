{ pkgs, ... }: {
  # Install khal via home-manager module
  programs.khal = {
    enable = true;
  };
}
