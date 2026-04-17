{ pkgs, ... }: {
  # FIXME: white pages
  service.printing = {
    enable = true;

    browsed.enable = true;
    cups-pdf.enable = true;

    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  service.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
