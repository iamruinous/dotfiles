{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}: {
  imports = [
    ./brew.nix
    ./fonts.nix
    ./system.nix
    ./shell.nix
    ./touch.nix
    ./user.nix
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
      inputs.fenix.overlays.default
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  nix.package = pkgs.nix;

  # Enable Nix daemon
  services.nix-daemon.enable = true;
}
