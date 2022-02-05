if status --is-interactive; and type -q keychain
  eval (keychain --eval --quiet id_ed25519 --agents ssh,gpg)
end
