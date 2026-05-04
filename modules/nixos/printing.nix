{ pkgs, ... }: {
  # FIXME: white pages
  services.printing = {
    enable = true;

    browsed.enable = true;
    cups-pdf.enable = true;

    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
