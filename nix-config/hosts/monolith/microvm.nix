{inputs, ...}: let
  inherit (inputs) microvm;
in {
  microvm.autostart = ["my-microvm"];
  microvm.vms = {
    my-microvm = {
      # (Optional) A set of special arguments to be passed to the MicroVM's NixOS modules.
      #specialArgs = {};

      # The configuration for the MicroVM.
      # Multiple definitions will be merged as expected.
      config = {
        # It is highly recommended to share the host's nix-store
        # with the VMs to prevent building huge images.
        microvm.shares = [
          {
            source = "/nix/store";
            mountPoint = "/nix/.ro-store";
            tag = "ro-store";
            proto = "virtiofs";
          }
        ];

        # Any other configuration for your MicroVM
        # [...]
      };
    };
  };
}
