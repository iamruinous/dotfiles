{
  description = "NixOS and nix-darwin configs for my machines";
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    wezterm.url = "github:wez/wezterm?dir=nix";

    # Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , darwin
    , home-manager
    , nix-homebrew
    , fenix
    , lanzaboote
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
      mkNixosConfiguration = hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            lanzaboote.nixosModules.lanzaboote
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
          ];
        };
    in
    {
      nixosConfigurations = {
        "framework" = mkNixosConfiguration "framework" "jmeskill";
        "obelisk" = mkNixosConfiguration "obelisk" "jmeskill";
        "moonstone" = mkNixosConfiguration "moonstone" "jmeskill";
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

