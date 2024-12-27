{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}: {
  # Add nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta =
      if pkgs.system == "aarch64-darwin"
      then true
      else false;
    user = "${userConfig.name}";
    autoMigrate = true;
  };

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
