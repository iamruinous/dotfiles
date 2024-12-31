{ pkgs, userConfig, ... }: {
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
      "step"
    ];
    casks = [
      "aerospace"
      "1password-cli"
      "blockblock"
      "claude"
      "cyberduck"
      "deskpad"
      "dropbox"
      "google-chrome"
      # "felixkratz/formulae/sketchybar"
      "jellyfin"
      "keka"
      "knockknock"
      "lulu"
      "mimestream"
      "obsidian"
      "oversight"
      "plex"
      "raycast"
      "soundsource"
      "wezterm"
    ];
    taps = [
      "nikitabobko/tap"
    ];
    onActivation.cleanup = "zap";
    masApps = {
      "Amphetamine" = 937984704;
      "aSPICEPro" = 1560593107;
      "Bitwarden" = 1352778147;
      "Fantastical" = 975937182;
      "Paprika3" = 1303222628;
      "PCalc" = 403504866;
      "PixelmatorPro" = 1289583905;
      "reMarkable" = 1276493162;
      "Tailscale" = 1475387142;
      "Todoist" = 585829637;
    };
  };
}
