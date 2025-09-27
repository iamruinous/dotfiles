{...}: {
  services.printing.cups-pdf = {
    enable = true;
    instances = {
      Paperless.settings.Out = "/nas/paperless/consume";
    };
  };

  hardware.printers.ensureDefaultPrinter = "Paperless";
}
