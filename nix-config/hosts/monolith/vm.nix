{
  userConfig,
  nixvirt,
  ...
}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [userConfig.name];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
