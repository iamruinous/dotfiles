{
  description = "NixOS and nix-darwin configs for my machines";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://wezterm.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
    extra-trusted-users = [
      "root"
      "jmeskill"
      "@wheel"
    ];
  };
  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?rev=d2faa1bbca1b1e4962ce7373c5b0879e5b12cef2";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Fenix for rust
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wezterm
    wezterm.url = "github:wez/wezterm?dir=nix";

    # Hyprland
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    walker.url = "github:abenz1267/walker";

    # Agenix for secrets
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    { self
    , darwin
    , home-manager
    , nix-homebrew
    , fenix
    , lanzaboote
    , walker
    , agenix
    , nixpkgs
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      # Define user configurations
      users = {
        jmeskill = {
          #avatar = ./files/avatar/face;
          email = "jade.meskill@gmail.com";
          fullName = "Jade Meskill";
          #gitKey = "C5810093";
          name = "jmeskill";
        };
      };

      # Function for NixOS system configuration
      mkNixosConfiguration = system: hostname: username:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
            }
          ];
        };

      # Function for nix-darwin system configuration
      mkDarwinConfiguration = system: hostname: username:
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
            }
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration = system: hostname: username:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            ./home/${username}/${hostname}.nix
            agenix.homeManagerModules.default
          ];
        };
    in
    {
      nixosConfigurations = {
        "framework" = mkNixosConfiguration "x86_64-linux" "framework" "jmeskill";
        "obelisk" = mkNixosConfiguration "x86_64-linux" "obelisk" "jmeskill";
        "moonstone" = mkNixosConfiguration "x86_64-linux" "moonstone" "jmeskill";
      };


      darwinConfigurations = {
        "studio" = mkDarwinConfiguration "x86_64-darwin" "studio" "jmeskill";
        "jbookair" = mkDarwinConfiguration "aarch64-darwin" "jbookair" "jmeskill";
        "jmacmini" = mkDarwinConfiguration "aarch64-darwin" "jmacmini" "jmeskill";
      };

      homeConfigurations = {
        "jmeskill@studio" = mkHomeConfiguration "x86_64-darwin" "studio" "jmeskill";
        "jmeskill@jbookair" = mkHomeConfiguration "aarch64-darwin" "jbookair" "jmeskill";
        "jmeskill@jmacmini" = mkHomeConfiguration "aarch64-darwin" "jmacmini" "jmeskill";
        "jmeskill@framework" = mkHomeConfiguration "x86_64-linux" "framework" "jmeskill";
        "jmeskill@obelisk" = mkHomeConfiguration "x86_64-linux" "obelisk" "jmeskill";
        "jmeskill@moonstone" = mkHomeConfiguration "x86_64-linux" "moonstone" "jmeskill";
      };

      overlays = import ./overlays { inherit inputs; };
    };
}

