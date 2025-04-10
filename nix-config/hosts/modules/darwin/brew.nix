{
  pkgs,
  userConfig,
  ...
}: {
  # Add nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta =
      if pkgs.system == "aarch64-darwin"
      then true
      else false;
    user = "${userConfig.name}";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    brews = [
      "boring"
      "mas"
      "step"
    ];
    casks = [
      "1password"
      "1password-cli"
      "aerospace"
      "balenaetcher"
      "blockblock"
      "claude"
      "cyberduck"
      "deskpad"
      "dropbox"
      "element"
      "gog-galaxy"
      "google-chrome"
      "jellyfin"
      "keka"
      "knockknock"
      "lulu"
      "mimestream"
      "obsidian"
      "oversight"
      "plex"
      "private-internet-access"
      "raycast"
      "slack"
      "soundsource"
      "spotify"
      "steam"
      "wezterm"
    ];
    taps = [
      "ggozad/formulas"
      "nikitabobko/tap"
    ];
    onActivation.cleanup = "zap";
    masApps = {
      "Amphetamine" = 937984704;
      "Bitwarden" = 1352778147;
      "Fantastical" = 975937182;
      "Kindle" = 302584613;
      "PCalc" = 403504866;
      "Paprika3" = 1303222628;
      "PixelmatorPro" = 1289583905;
      "Tailscale" = 1475387142;
      "Todoist" = 585829637;
      "aSPICEPro" = 1560593107;
      "reMarkable" = 1276493162;
    };
  };
}
