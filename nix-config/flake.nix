{
  description = "Darwin configuration for jbookair";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, nixpkgs-unstable, nixpkgs-darwin }:
  let
    inputs = { inherit home-manager nixpkgs nixpkgs-unstable nix-darwin; };

    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      # environment.systemPackages = with pkgs;
      #   [ 
      #     vim
      #   ];
      #
      # # Auto upgrade nix package and the daemon service.
      # services.nix-daemon.enable = true;
      nix.package = pkgs.nixVersions.latest;

      # Necessary for using flakes on this system.
      # nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      # programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;



      # system.defaults = {
      #   # minimal dock
      #   dock = {
      #     autohide = true;
      #     magnification = true;
      #     largesize = 96;
      #     orientation = "bottom";
      #     static-only = false;
      #     show-process-indicators = true;
      #     show-recents = true;
      #   };
      #   # a finder that tells me what I want to know and lets me work
      #   finder = {
      #     AppleShowAllExtensions = true;
      #     ShowPathbar = true;
      #     FXEnableExtensionChangeWarning = false;
      #   };
      #   # Tab between form controls and F-row that behaves as F1-F12
      #   NSGlobalDomain = {
      #     AppleKeyboardUIMode = 3;
      #     "com.apple.keyboard.fnState" = true;
      #   };
      # };

      # The platform the configuration will be used on.
      # nixpkgs.hostPlatform = "x86_64-darwin";
    };

    homeconfig = { pkgs, ... }: {
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;

      home.packages = with pkgs; [
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      }; 

      programs.fish = {
        enable = true;
        shellAbbrs = {
          dl = "curl --create-dirs -O --output-dir /tmp/";
        };

        functions = {
          fish_user_key_bindings = ''
            bind \t complete-and-search
            bind \cw backward-kill-word

            # Alt+left
            bind \e\[1\;3D backward-kill-bigword
            bind \ek kill-whole-line
          '';

          ls = {
            wraps = "eza";
            body = "eza --git --icons -ga --group-directories-first $argv";
          };

          ll = {
            wraps = "ls";
            body = "ls -lahF $argv";
          };

          l = {
            wraps = "xplr";
            body = "xplr $argv";
          };

          find = {
            wraps = "fd";
            body = "fd --follow --hidden $argv";
          };

          cat = {
            wraps = "bat";
            body = "bat $argv";
          };

          top = {
            wraps = "btop";
            body = "btop $argv";
          };

          history = "builtin history --show-time='%h/%d - %H:%M:%S ' | moar";

          tree = {
            wraps = "eza";
            body = "eza --git --icons --tree $argv";
          };

          ps = {
            wraps = "procs";
            body = "procs $argv";
          };

          pkill = "command pkill -f -e $argv";

          df = {
            wraps = "duf";
            body = "duf --hide-fs tmpfs,vfat,devfs,devtmpfs $argv";
          };

          du = {
            wraps = "dust";
            body = "dust -b $argv";
          };

          cal = {
            wraps = "khal";
            body = "khal $argv";
          };

          call = "cal list";
          cala = "cal calendar";
          cali = "ikhal";

          vim = {
            wraps = "nvim";
            body = "nvim $argv";
          };

          vi = "vim";
        };

        plugins = with pkgs.fishPlugins; [
          {
            name = "fzf-fish";
            src = fzf-fish.src;
          }
        ];
      };

      programs.starship = {
        enable = true;
        enableTransience = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };

    genPkgs = system: import nixpkgs { inherit system; config.allowUnfree = true; };
    genUnstablePkgs = system: import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    genDarwinPkgs = system: import nixpkgs-darwin { inherit system; config.allowUnfree = true; };

    # creates a nixos system config
    nixosSystem = system: hostname: username:
      let
        pkgs = genPkgs system;
        unstablePkgs = genUnstablePkgs system;
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit pkgs unstablePkgs;
            # lets us use these things in modules
            customArgs = { inherit system hostname username pkgs unstablePkgs; };
          };
          modules = [
            #disko.nixosModules.disko
            #./hosts/nixos/${hostname}/disko-config.nix

            ./hosts/nixos/${hostname}

            home-manager.nixosModules.home-manager {
              networking.hostName = hostname;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = { imports = [ ./home/${username}.nix ]; };
            }
            ./hosts/common/nixos-common.nix
          ];
        };

    # creates a macos system config
    darwinSystem = system: hostname: username:
      let
        pkgs = genDarwinPkgs system;
      in
        nix-darwin.lib.darwinSystem {
          inherit system inputs;
          specialArgs = {
            # adds unstable to be available in top-level evals (like in common-packages)
            unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};

            # lets us use these things in modules
            customArgs = { inherit system hostname username pkgs; };
          };
          modules = [
            ./hosts/darwin/${hostname} # ip address, host specific stuff
            home-manager.darwinModules.home-manager {
              networking.hostName = hostname;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = { imports = [ ./home/${username}.nix ]; };
            }
            ./hosts/common/darwin-common.nix
          ];
        };
  in {
    darwinConfigurations = {
      jbookair = darwinSystem "aarch64-darwin" "jbookair" "jmeskill";
      jmacmini = darwinSystem "aarch64-darwin" "jmacmini" "jmeskill";
      studio = darwinSystem "x86_64-darwin" "studio" "jmeskill";
    };

    nixosConfigurations = {
      # use this for a blank ISO + disko to work
      nixos = nixosSystem "x86_64-linux" "nixos" "jmeskill";
    };
  };
}
