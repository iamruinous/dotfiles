{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.virtualisation.libvirtd;
in {
  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;

    users.users.jmeskill.extraGroups = ["libvirtd" "kvm"]; # TODO: generalize user
    networking.firewall.allowedTCPPorts = [5900];

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-protocol
      win-virtio
      win-spice
    ];

    virtualisation = {
      # libvirt.enable = lib.mkDefault true;
      libvirtd = {
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [
              (pkgs.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              }).fd
            ];
          };
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
    services.spice-autorandr.enable = true;

    security.acme = {
      acceptTerms = true;
      defaults.email = "admin@meskill.network";
      certs = {
        "${config.networking.hostName}.meskill.farm" = {
          domain = "${config.networking.hostName}.meskill.farm";
          # group = "nginx";
          dnsProvider = "cloudflare";
          # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#EnvironmentFile=
          environmentFile = config.age.secrets.acme_cloudflare_env.path;
        };
      };
    };

    age.secrets.acme_cloudflare_env = {
      file = ../../../hosts/${config.networking.hostName}/files/acme/cloudflare.env.age;
      mode = "600";
    };

    services.networking.websockify = {
      enable = lib.mkDefault true;
      sslCert = "/var/lib/acme/${config.networking.hostName}.meskill.farm/fullchain.pem";
      sslKey = "/var/lib/acme/${config.networking.hostName}.meskill.farm/key.pem";
      portMap = {
        "5959" = 5900;
        "5960" = 5901;
        # "5961" = 5902;
      };
    };
  };
}
