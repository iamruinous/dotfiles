{pkgs, ...}: {
  imports = [
    ./common.nix
    ./1password.nix
    ./fonts.nix
    ./pipewire.nix
    ./print.nix
    ./sudoless.nix
    ./tailscale.nix
    ./user.nix
    ./xserver.nix
  ];

  environment.systemPackages = with pkgs; [
    sbctl
    fastfetch
    google-chrome
    obsidian
    todoist-electron
  ];
}
