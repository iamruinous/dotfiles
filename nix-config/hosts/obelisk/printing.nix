{pkgs, ...}: {
  services.printing.drivers = [
    pkgs.nelko-pl70ebt
  ];
  hardware.printers = {
    ensurePrinters = [
      {
        name = "PL70e-BT";
        location = "Studio Desk";
        deviceUri = "usb:///PL70e-BT?serial=YY33230312";
        ppdOptions = {
          PageSize = "100x150mm";
        };
        model = "Nelko/PL70e-BT.ppd";
      }
    ];
  };

  hardware.printers.ensureDefaultPrinter = "PL70e-BT";
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    cups
  ];
}
