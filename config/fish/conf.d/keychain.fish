if status --is-interactive; and type -q keychain
  eval (keychain --eval --quiet --agents ssh,gpg id_ed25519 id_jademeskill_ed25519 00AB98E4EDFA6211 CA5500A8F3A920A0)
end
