{ pkgs, ... }: {
  # Install eza via home-manager module
  programs.eza = {
    enable = true;
  };
}
