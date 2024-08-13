{ pkgs, lib, inputs, customArgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  # Nix configuration ------------------------------------------------------------------------------
  users.users.jmeskill.home = "/Users/jmeskill";
  users.users.jmeskill.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8rjXP/sjewv6kM1aTtNWkVZKJpZvIAXIRqL81IyEsm iamruinous@ruinous.social"
  ];

  nix = {
    package = pkgs.nixVersions.git;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };
  services.nix-daemon.enable = true;

  # pins to stable as unstable updates very often
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry = {
    n.to = {
      type = "path";
      path = inputs.nixpkgs;
    };
    u.to = {
      type = "path";
      path = inputs.nixpkgs-unstable;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.overlays = [
    (final: prev: lib.optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
      # Add access to x86 packages system is running Apple Silicon
      pkgs-x86 = import nixpkgs {
        system = "x86_64-darwin";
        config.allowUnfree = true;
      };
    })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = false;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #promptInit = (builtins.readFile ./../mac-dot-zshrc);
    #interactiveShellInit = "figurine -f \"3d.flf\" ${customArgs.hostname}";
  };

  programs.fish = {
    enable = true;
  };

  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryPackage = pkgs.pinentry_mac;
    };
  };

  programs.direnv = {
    enable = true;
    # enableBashIntegration = true;
    # enableFishIntegration = true;
    # enableZshIntegration = true;
  };
 
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    taps = [
      "homebrew/cask-fonts"
    ];

    brews = [
    ];

    casks = [
      "1password-cli"
      "blockblock"
      "dropbox"
      "font-bigblue-terminal-nerd-font"
      "font-fira-code-nerd-font"
      "keka"
      "knockknock"
      "lulu"
      "mimestream"
      "obsidian"
      "oversight"
      "soundsource"
      "todoist"
      "wezterm"
    ];

    masApps = {
      "Amphetamine" = 937984704;
      "Fantastical" = 975937182;
      "Todoist" = 585829637;
    };
  };

  # macOS configuration
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    #NSGlobalDomain.AppleShowScrollBars = "Always";
    NSGlobalDomain.NSUseAnimatedFocusRing = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 4;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    LaunchServices.LSQuarantine = false; # disables "Are you sure?" for new apps
    loginwindow.GuestEnabled = false;

  };
  system.defaults.CustomUserPreferences = {
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
        FXEnableExtensionChangeWarning = false;
        ShowStatusBar = true;
        ShowPathbar = true;
        WarnOnEmptyTrash = false;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.dock" = {
        autohide = true;
        launchanim = false;
        static-only = false;
        show-recents = true;
        show-process-indicators = true;
        orientation = "bottom";
        tilesize = 36;
        minimize-to-application = true;
        mineffect = "scale";
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
  };

}
