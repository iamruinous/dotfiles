{lib, ...}: {
  # Install and configure Golang via home-manager module
  programs.go = {
    enable = lib.mkDefault true;
    goBin = "go/bin";
    goPath = "go";
  };

  # Ensure Go bin in the PATH
  home.sessionPath = [
    "$HOME/go/bin"
  ];
}
