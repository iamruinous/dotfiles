{ pkgs, unstablePkgs, ... }:
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
    tmux
    xplr
    xz

    # dev tools
    jq
    just
    ripgrep
    lazygit
    unstablePkgs.neovim
    git
    git-secrets

    # languages
    go
    nodejs
    python3
    unstablePkgs.uv
    zig

    # prompt stuff
    figlet
    fortune
    lolcat
    neofetch
    starship
    toilet
  ];
}
