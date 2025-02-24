{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["jmeskill" "@wheel"];
  };
#  nix.optimise.automatic = true;

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

  # System packages
  environment.systemPackages = with pkgs; [
    # config management
    age
    chezmoi

    # utils
    cargo-binstall
    duf
    dust
    fd
    gnupg
    moar
    mosh
    procs
    rsync
    xplr
    xz

    # prompt stuff
    figlet
    fortune
    lolcat
    neofetch
    toilet
  ];

  # Zsh configuration
  programs.zsh.enable = true;

  # Fish configuration
  programs.fish.enable = true;
}
