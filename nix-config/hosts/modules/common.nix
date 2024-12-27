{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}: {

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
}
