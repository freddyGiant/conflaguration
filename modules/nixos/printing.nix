{ pkgs, ... }: {
  # FIXME: white pages
  services.printing.enable = true;

  services.printing.browsed.enable = true;
  services.printing.cups-pdf.enable = true;
  services.printing.drivers = with pkgs; [
    cups-filters
    cups-browsed
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
