{
  pkgs,
  userConfig,
  ...
}: {
  programs.dconf.enable = true;

  users.users.${userConfig.name}.extraGroups = ["libvirtd" "kvm"];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-protocol
    win-virtio
    win-spice
  ];

  networking.firewall.trustedInterfaces = ["virbr0"];
  networking.firewall.extraForwardRules = ''
    iifname "virbr0" accept
    oifname "virbr0" ct state established,related accept
  '';

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
        verbatimConfig = ''
          vnc_listen = "0.0.0.0"
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  services.spice-autorandr.enable = true;
}
