{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sbctl
    fastfetch
    google-chrome
    obsidian
    todoist-electron
  ];
}
