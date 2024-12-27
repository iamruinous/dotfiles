{ pkgs
, outputs
, userConfig
, ...
}: {
  # Add nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    user = "${userConfig.name}";
    autoMigrate = true;
  };

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  nix.package = pkgs.nix;

  # Enable Nix daemon
  services.nix-daemon.enable = true;

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8rjXP/sjewv6kM1aTtNWkVZKJpZvIAXIRqL81IyEsm iamruinous@ruinous.social"
    ];
    shell = pkgs.fish;
  };


  # Add ability to use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # System settings
  system = {
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.mouse.scaling" = -1.0;
      };
      loginwindow.GuestEnabled = false;
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSUseAnimatedFocusRing = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        NSDocumentSaveNewDocumentsToCloud = true;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 25;
        KeyRepeat = 4;
        "com.apple.mouse.tapBehavior" = 1;
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.ActivityMonitor" = {
          OpenMainWindow = true;
          IconType = 5;
          SortColumn = "CPUUsage";
          SortDirection = 0;
        };
        "com.apple.Safari" = {
          # Privacy: don’t send search queries to Apple
          UniversalSearchEnabled = false;
          SuppressSearchSuggestions = true;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 1;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
        };
        "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
        # Turn on app auto-update
        "com.apple.commerce".AutoUpdate = true;
        "com.googlecode.iterm2".PromptOnQuit = false;
        "com.google.Chrome" = {
          AppleEnableSwipeNavigateWithScrolls = true;
          DisablePrintPreview = true;
          PMPrintingExpandedStateForPrint2 = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
          DisableAllAnimations = true;
          NewWindowTarget = "PfDe";
          NewWindowTargetPath = "file://$\{HOME\}/Desktop/";
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          FXEnableExtensionChangeWarning = false;
          ShowStatusBar = true;
          ShowPathbar = true;
          WarnOnEmptyTrash = false;
        };
      };
      trackpad = {
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
        Clicking = true;
      };
      dock = {
        autohide = true;
        launchanim = false;
        static-only = false;
        show-recents = true;
        show-process-indicators = true;
        orientation = "bottom";
        tilesize = 36;
        minimize-to-application = true;
        mineffect = "scale";
        persistent-apps = [
          "/Applications/Google Chrome.app"
          "${pkgs.wezterm}/Applications/WezTerm.app"
        ];
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
      screencapture = {
        location = "/Users/${userConfig.name}/Screenshots/temp";
        type = "png";
        disable-shadow = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    jankyborders
  ];

  # Zsh configuration
  programs.zsh.enable = true;

  # Fish configuration
  programs.fish.enable = true;

  # direnv configuration
  programs.direnv.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.bigblue-terminal
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.monaspace
  ];

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

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
