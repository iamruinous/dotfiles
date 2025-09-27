# overlays/nelko.nix
self: super: {
  nelko-pl70ebt = self.callPackage ../packages/nelko-pl70ebt { };
}
