{ pkgs, unstablePkgs, lib, inputs, customArgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
  username = customArgs.username;
in
{
  users.users.${username} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8rjXP/sjewv6kM1aTtNWkVZKJpZvIAXIRqL81IyEsm iamruinous@ruinous.social"
    ];
    shell = pkgs.fish;
  };

  time.timeZone = "America/Phoenix";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
    "1password"
    "1password-gui"
  ];

  environment.systemPackages = with pkgs; [
  ];

  programs.fish = {
    enable = true;
  };

  ## pins to stable as unstable updates very often
  # nix.registry.nixpkgs.flake = inputs.nixpkgs;
  # nix.registry = {
  #   n.to = {
  #     type = "path";
  #     path = inputs.nixpkgs;
  #   };
  #   u.to = {
  #     type = "path";
  #     path = inputs.nixpkgs-unstable;
  #   };
  # };
}
