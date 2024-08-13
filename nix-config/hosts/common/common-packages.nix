{ pkgs, unstablePkgs, ... }:
{
  fonts.packages = with pkgs; [
    fira-code
    fira-code-nerdfont
    fira-mono
    monaspace
  ];

  environment.systemPackages = with pkgs; [
    # config management
    age
    chezmoi

    # utils
    bat
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
    neovim
    git
    git-secrets

    # languages
    go
    nodejs
    pipx
    python3
    rye
    zig

    # window manager
    jankyborders
    skhd
    yabai

    # prompt stuff
    figlet
    fortune
    lolcat
    neofetch
    starship
    toilet
  ];
}
