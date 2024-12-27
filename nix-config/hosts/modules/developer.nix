{ inputs
, outputs
, lib
, config
, userConfig
, pkgs
, ...
}: {

  # System packages
  environment.systemPackages = with pkgs; [
    # dev tools
    jq
    just
    ripgrep
    lazygit
    luarocks
    git-secrets

    # languages
    go
    nodejs
    (python3.withPackages (ps: with ps; [ pip virtualenv ]))
    uv
    zig

    # rust
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];
}
