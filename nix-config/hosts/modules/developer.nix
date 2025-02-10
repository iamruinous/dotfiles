{ pkgs, ... }: {

  # System packages
  environment.systemPackages = with pkgs; [
    # dev tools
    git-secrets
    jq
    just
    lazygit
    luarocks
    ripgrep

    # languages
    go
    nodejs
    (python3.withPackages (ps: with ps; [ pip virtualenv ]))
    basedpyright
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
