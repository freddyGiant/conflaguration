{ pkgs, ... }: {
  # $ fc-list | grep -i 'font-name' | sed 's/^.*: //'

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    open-sans
    # FIXME: where does this appear?
    openmoji-color
  ];

  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    # hinting = "full";
    subpixelRendering = "rgb";
  };

  fonts.fontconfig.defaultFonts = {
    # FIXME: what is this actually called? see command at top lol
    emoji = [ "openmoji-color" ];
    monospace = [ "JetBrainsMono NFM" ];
    sansSerif = [ "open-sans" ];
  };
}
