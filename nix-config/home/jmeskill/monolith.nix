{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) NixVirt;
in {
  imports = [
    ../modules/common.nix
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # virt-manager stuff
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # home.packages = [
  #   NixVirt.packages.${pkgs.system}.default
  # ];
  #
  # virtualisation.libvirt.connections."qemu:///session".domains = [
  #   {
  #     definition = NixVirt.lib.domain.writeXML (
  #       NixVirt.lib.domain.templates.linux
  #       {
  #         name = "vmtest";
  #         uuid = "c0f4bf20-712a-4cd5-a09d-332877246a52";
  #         memory = {
  #           count = 2;
  #           unit = "GiB";
  #         };
  #         storage_vol = {
  #           pool = "linuxvms";
  #           volume = "vmtest.qcow2";
  #         };
  #       }
  #     );
  #   }
  # ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
