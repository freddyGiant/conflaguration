{
  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;

  programs.niri.settings.binds = {
    "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-1" "1.0"];
    "XF86AudioRaiseVolume".hotkey-overlay.title = "raise volume";
    "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
    "XF86AudioLowerVolume".hotkey-overlay.title = "lower volume";
  };
}
