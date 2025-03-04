{pkgs, ...}: {
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
    (python3.withPackages (ps: with ps; [pip virtualenv]))
    uv
    zig

    # lsp and formatters
    alejandra
    basedpyright
    biome
    harper
    lemminx
    lua-language-server
    marksman
    nil
    ruff
    selene
    stylua
    taplo
    typos-lsp
    yaml-language-server
    zls

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
