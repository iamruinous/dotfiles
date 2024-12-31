{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}: {
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
