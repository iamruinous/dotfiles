let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8rjXP/sjewv6kM1aTtNWkVZKJpZvIAXIRqL81IyEsm";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcg4sQO+hRaGrHLLU0pXl7tEZIQGkmwxiA9klN0p6h+";
  users = [ user1 user2 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBucoQ40ZvFyVdqtLqcITFVflxliTOHddWIso4fGwlX+";
  system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVXtjGlDK/b/8KU5edVlMcF/pcrcqlm4S2o94XtGOPD";
  system3 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnhRtaSC1HFo3hF2Wdq2KzgCTk1/5BlAZvjkE2ZZauo";
  systems = [ system1 system2 system3 ];
in
{
  "vdirsyncer-google-jadeisfalling-client-secret.age".publicKeys = users ++ systems;
  "vdirsyncer.age".publicKeys = users ++ systems;
}
