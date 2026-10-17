{ pkgs, ... }: {
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    # drivers for a bunch of common printers
    foomatic-db-ppds
    foomatic-db-ppds-withNonfreeDb
  ];

  # services.printing.browsed.enable = true;
  # services.printing.cups-pdf.enable = true;
  # services.printing.drivers = with pkgs; [
  #   cups-filters
  #   cups-browsed
  # ];
  #
  # services.avahi.enable = true;
  # services.avahi.nssmdns4 = true;
  # services.avahi.openFirewall = true;
}
