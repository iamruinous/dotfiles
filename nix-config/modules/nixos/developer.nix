{
  flake,
  pkgs,
  ...
}: {
  imports = [flake.nixosModules.default];

  nixpkgs = {
    overlays = [
      # flake.outputs.overlays.stable-packages
      flake.inputs.fenix.overlays.default
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # dev tools
    aider-chat
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
    # zig # TODO: broken

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
    # zls # TODO: zig broken

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
