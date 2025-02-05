{ pkgs, unstablePkgs, system, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "BigBlueTerminal"
        "DroidSansMono"
        "FiraCode"
        "Monaspace"
      ];
    })
  ];

  environment.systemPackages = with pkgs; [
    # config management
    age
    unstablePkgs.chezmoi

    # utils
    bat
    bottom
    btop
    cargo-binstall
    duf
    dust
    eza
    fd
    fzf
    gnupg
    htop
    # keychain
    khal
    moar
    mosh
    # pinentry_mac
    procs
    rsync
    tmux
    vdirsyncer
    xplr
    xz

    # dev tools
    jq
    just
    ripgrep
    lazygit
    luarocks
    unstablePkgs.neovim
    git
    git-secrets

    # languages
    go
    nodejs
    python3
    unstablePkgs.uv
    zig

    # rust
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly

    # prompt stuff
    figlet
    fortune
    lolcat
    neofetch
    starship
    toilet
  ];
}
