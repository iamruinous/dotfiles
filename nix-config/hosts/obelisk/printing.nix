{pkgs, ...}: {
  services.printing.drivers = [
    pkgs.nelko-pl70ebt
  ];
  hardware.printers = {
    ensurePrinters = [
      {
        name = "PLT70e-BT";
        location = "Studio Desk";
        deviceUri = "usb://Dell/1250c%20Color%20Printer?serial=YNP023240";
        model = "Dell-1250c.ppd.gz";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
