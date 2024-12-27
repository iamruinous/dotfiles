{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  # networking.hostName = "nixos";

  nix.settings.sandbox = false;
}
