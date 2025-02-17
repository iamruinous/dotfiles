let
  jmeskill = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/j8GXfs4yVEA2oIhAgAruX/f7Cg/Il6dKMmyIllqa0";
  users = [jmeskill];

  jbookair = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnhRtaSC1HFo3hF2Wdq2KzgCTk1/5BlAZvjkE2ZZauo";
  obelisk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKz0mrGO9wDTjOq7wC8w5EFIxB0e/vKBGLnOL/kx7Ov+";
  studio = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVXtjGlDK/b/8KU5edVlMcF/pcrcqlm4S2o94XtGOPD";
  jmacmini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBucoQ40ZvFyVdqtLqcITFVflxliTOHddWIso4fGwlX+";
  framework = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKz0mrGO9wDTjOq7wC8w5EFIxB0e/vKBGLnOL/kx7Ov+";
  systems = [
    framework
    jbookair
    jmacmini
    obelisk
    studio
  ];
in {
  "files/configs/caddy/caddy.env.age".publicKeys = users ++ [obelisk];
  "files/configs/vdirsyncer/config.age".publicKeys = users ++ systems;
  "files/configs/todoist/config.json.age".publicKeys = users ++ systems;
  "files/configs/restic/restic-password.age".publicKeys = users ++ systems;
}
