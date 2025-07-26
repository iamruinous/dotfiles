let
  jmeskill = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/j8GXfs4yVEA2oIhAgAruX/f7Cg/Il6dKMmyIllqa0";
  all_users = [jmeskill];

  framework = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8xqxaR93hZCPoHmuZDi3NrIF/JD/1nFG4rV7O7iR26";
  jbookair = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnhRtaSC1HFo3hF2Wdq2KzgCTk1/5BlAZvjkE2ZZauo";
  jmacmini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBucoQ40ZvFyVdqtLqcITFVflxliTOHddWIso4fGwlX+";
  monolith = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHzI0xVuc0SbWyDk+sVC5N3W4FzcAPOd5JCoJfTU2mTF";
  obelisk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKz0mrGO9wDTjOq7wC8w5EFIxB0e/vKBGLnOL/kx7Ov+";
  studio = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVXtjGlDK/b/8KU5edVlMcF/pcrcqlm4S2o94XtGOPD";

  darwin_systems = [
    jbookair
    jmacmini
    studio
  ];

  linux_systems = [
    framework
    monolith
    obelisk
  ];

  all_systems = linux_systems ++ darwin_systems;
in {
  "files/configs/vdirsyncer/config.age".publicKeys = all_users ++ all_systems;
  "files/configs/todoist/config.json.age".publicKeys = all_users ++ all_systems;
  "files/configs/restic/restic-password.age".publicKeys = all_users ++ linux_systems;

  "hosts/obelisk/files/caddy/caddy.env.age".publicKeys = [jmeskill obelisk];

  "hosts/monolith/files/acme/cloudflare.env.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/caddy/Caddyfile.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/glance/glance.yml.age".publicKeys = [jmeskill monolith];

  "hosts/monolith/files/docker/env/mariadb.env.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/docker/env/piavpn.env.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/docker/env/postgres.env.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/docker/env/romm.env.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/docker/env/stepca.env.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/docker/env/weatherflow.env.age".publicKeys = [jmeskill monolith];

  "hosts/monolith/files/rtl_433/rtl_433.conf.age".publicKeys = [jmeskill monolith];
  "hosts/monolith/files/rtl_433/rtl_915.conf.age".publicKeys = [jmeskill monolith];
}
