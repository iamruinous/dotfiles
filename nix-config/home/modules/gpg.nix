{ pkgs, ... }: {
  # Install gpg via home-manager module
  programs.gpg = {
    enable = true;
  };
}
