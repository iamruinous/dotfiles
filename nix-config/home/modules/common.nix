{
  config,
  outputs,
  ...
}: {
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
    # ./keychain.nix
    ./khal.nix
    ./neovim.nix
    ./oterm.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./todoist.nix
    ./todoist-auto.nix
    ./vdirsyncer.nix
    ./vdirsyncer-auto.nix
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

  age.identityPaths = ["${config.home.homeDirectory}/.ssh/id_dotfiles_ed25519"];
}
