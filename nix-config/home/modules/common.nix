{ outputs, ... }: {
  imports = [
    ./bat.nix
    ./bottom.nix
    ./btop.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./go.nix
    ./home.nix
    ./keychain.nix
    ./khal.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./vdirsyncer.nix
    ./vdirsyncer-auto.nix
    ./wezterm.nix
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };
}
