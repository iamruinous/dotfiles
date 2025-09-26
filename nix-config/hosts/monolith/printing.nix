{...}: {
  services.printing.enable = true;
  fonts.enableDefaultPackages = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.printing = {
    listenAddresses = ["*:631"];
    allowFrom = ["all"];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    cups-pdf = {
      enable = true;
      instances = {
        Paperless.settings.Out = "/nas/paperless/consume";
      };
    };
  };

  hardware.printers.ensureDefaultPrinter = "Paperless";
}
