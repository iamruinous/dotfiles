{pkgs, ...}: {
  # System packages
  environment.systemPackages = with pkgs; [
    # dev tools
    #aider-chat
    devenv
    git-secrets
    jq
    just
    lazygit
    luarocks
    #playwright
    #playwright-driver.browsers
    ripgrep

    # languages
    go
    nodejs
    (python3.withPackages (ps:
      with ps; [
        pip
        virtualenv
        llm
        llm-anthropic
        llm-gemini
      ]))
    uv
    zig

    # lsp and formatters
    alejandra
    basedpyright
    biome
    golangci-lint
    golangci-lint-langserver
    gopls
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
