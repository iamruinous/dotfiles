let
  jmeskill = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/j8GXfs4yVEA2oIhAgAruX/f7Cg/Il6dKMmyIllqa0";
  users = [ jmeskill ];

  jbookair = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnhRtaSC1HFo3hF2Wdq2KzgCTk1/5BlAZvjkE2ZZauo";
  obelisk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKz0mrGO9wDTjOq7wC8w5EFIxB0e/vKBGLnOL/kx7Ov+";
  systems = [ jbookair obelisk ];
in
{
  "files/configs/caddy/root_ca.crt.age".publicKeys = users ++ [ obelisk ];
}

