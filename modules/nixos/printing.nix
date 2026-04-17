{ pkgs, ... }: {
  # FIXME: white pages
  printing = {
    enable = true;

    browsed.enable = true;
    cups-pdf.enable = true;

    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
}
