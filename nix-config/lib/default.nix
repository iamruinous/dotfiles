{
  flake,
  inputs,
  ...
}: let
  # Module args with lib included
  inherit (inputs.nixpkgs) lib;
  args = {inherit flake inputs lib;};
in rec {
  # List directories and files that can be imported by nix
  ls = import ./ls.nix args;
}
