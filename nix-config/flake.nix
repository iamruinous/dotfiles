{
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.1";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    wezterm.url = "github:wez/wezterm?dir=nix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";

    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixos-hardware, home-manager, nix-darwin, nixpkgs, nixpkgs-unstable, nixpkgs-darwin, lanzaboote, ... }:
  let
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
            inherit pkgs unstablePkgs inputs;

            # lets us use these things in modules
            customArgs = { inherit system hostname username pkgs unstablePkgs; };
          };

          modules = [
            #disko.nixosModules.disko
            #./hosts/nixos/${hostname}/disko-config.nix
            
            lanzaboote.nixosModules.lanzaboote
            ./hosts/nixos/${hostname}
            ./hosts/common/nixos-common.nix
          ];
        };

    # creates a nixos home-manager system config
    nixosHMSystem = system: hostname: username: extraModules:
      let
        pkgs = genPkgs system;
        unstablePkgs = genUnstablePkgs system;
      in
        nixpkgs.lib.nixosSystem {
          inherit system extraModules;
          specialArgs = {
            inherit pkgs unstablePkgs inputs;

            # lets us use these things in modules
            customArgs = { inherit system hostname username pkgs unstablePkgs; };
          };

          modules = [
            #disko.nixosModules.disko
            #./hosts/nixos/${hostname}/disko-config.nix

            lanzaboote.nixosModules.lanzaboote
            ./hosts/nixos/${hostname}

            home-manager.nixosModules.home-manager {
              home-manager.extraSpecialArgs = { inherit inputs; };
              networking.hostName = hostname;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = { imports = [ ./home/${username} ]; };
            }

            ./hosts/common/nixos-common.nix
          ] ++ extraModules;
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
              home-manager.extraSpecialArgs = { inherit inputs; };
              networking.hostName = hostname;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = { imports = [ ./home/${username} ]; };
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
      nixos = nixosHMSystem "x86_64-linux" "nixos" "jmeskill";
      # non-home managed systems
      touchstone = nixosSystem "x86_64-linux" "touchstone" "xfer";
      # home managed systems
      nixie = nixosHMSystem "x86_64-linux" "nixie" "jmeskill";
      nixai = nixosHMSystem "x86_64-linux" "nixai" "jmeskill";
      framework = nixosHMSystem "x86_64-linux" "framework" "jmeskill" [nixos-hardware.nixosModules.framework-13th-gen-intel];
    };
  };
}
