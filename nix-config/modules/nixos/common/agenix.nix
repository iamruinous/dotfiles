{flake, ...}: {
  imports = [
    flake.inputs.agenix.nixosModules.default
  ];
}
