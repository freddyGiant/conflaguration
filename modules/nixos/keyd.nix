{
  services.keyd = {
    enable = true;
    settings = {
      # all devices (change?)
      # ids = [ "*" ];
      main = {
        meta = "layer(alt)";
        leftalt = "layer(meta)";
        rightalt = "escape";

        # # Left Ctrl activates vim-style navigation
        # leftcontrol = "layer(nav)";

        # CapsLock behaves as control until space is pressed, at which
        # points it activates vim-style navigation
        capslock = "layer(ctrl_nav)";

        # Pressing both Shift keys toggles CapsLock
        shift = "layer(shift_capslock)";
      };

      "ctrl_nav:C" = {
        space = "swap(nav)";
      };

      "nav:C" = {
        h = "left";
        j = "down";
        k = "up";
        l = "right";

        w = "C-right";
        b = "C-left";
      };

      "shift_capslock:S" = {
        shift = "capslock";
      };
    };
  };
}
