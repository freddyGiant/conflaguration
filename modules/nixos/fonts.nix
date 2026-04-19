{
  # $ fc-list | grep -i 'font-name' | sed 's/^.*: //'
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    # hinting = "full";
    subpixelRendering = "rgb";

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      open-sans
      # FIXME: where does this appear?
      openmoji-color
    ];

    defaultFonts = {
      monospace = [ "JetBrainsMono NFM" ];
      sans-serif = [ "open-sans" ];
    };
  };
}
