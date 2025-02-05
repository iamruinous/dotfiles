{ pkgs, ... }: {
  # Fonts configuration
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.bigblue-terminal
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.monaspace
  ];
}
