{ outputs, ... }: {
  imports = [
    ../modules/bat.nix
    ../modules/bottom.nix
    ../modules/btop.nix
    #    ../modules/chezmoi.nix
    ../modules/eza.nix
    ../modules/fish.nix
    ../modules/fzf.nix
    ../modules/git.nix
    ../modules/go.nix
    ../modules/home.nix
    ../modules/keychain.nix
    ../modules/khal.nix
    ../modules/neovim.nix
    ../modules/ssh.nix
    ../modules/starship.nix
    ../modules/tmux.nix
    ../modules/vdirsyncer.nix
    ../modules/vdirsyncer-auto.nix
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
