{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) NixVirt nixpkgs;
  debian-netinst = pkgs.fetchurl {
    url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso";
    hash = "sha256-Elc3PHBtjAfmkXlCc2qGXf/1V9IdduowQLsQOetyoFQ=";
  };
in {
  imports = [
    ../modules/common.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # virt-manager stuff
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };
  #
  # # home.packages = [
  # #   NixVirt.packages.${pkgs.system}.default
  # # ];
  # #
  # virtualisation.libvirt.enable = true;
  # virtualisation.libvirt.verbose = true;
  #
  # virtualisation.libvirt.connections."qemu:///session" = {
  #   domains = [
  #     {
  #       active = true;
  #       definition = ../../hosts/monolith/files/libvirt/domains/debiantest.xml;
  #       definition = NixVirt.lib.domain.writeXML (
  #         NixVirt.lib.domain.templates.linux
  #         {
  #           name = "debiantest";
  #           uuid = "c0f4bf20-712a-4cd5-a09d-332877246a52";
  #           memory = {
  #             count = 2;
  #             unit = "GiB";
  #           };
  #           storage_vol = {
  #             pool = "devel";
  #             volume = "debiantest.qcow2";
  #           };
  #           install_vol = "${debian-netinst}";
  #           virtio_video = false;
  #         }
  #       );
  #     }
  #   ];
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
