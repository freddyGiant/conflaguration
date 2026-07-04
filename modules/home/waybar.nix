{ pkgs, ... }: {
  home.programs = with pkgs; [ power-profiles-daemon ];

  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    height = 20;
    spacing = 10;

    modules-center = [ "clock" "battery" "power-profiles-daemon" ];

    clock.format = "%H:%M:%S %A %d %B %Y";
    clock.interval = 1;

    battery = {
      format          = "- {capacity} -";
      format-plugged  = "~ {capacity} ~";
    };
    battery.states.critical = 12;

    modules-right = [ "pulseaudio" "temperature" "tray" ];

    pulseaudio = {
      format       = "{volume}%   {format_source}";
      # FIXME: coffee mug???
      format-muted = "󰅶 {format_source}";
      format-bluetooth       = "{volume}%  {format_source}";
      format-bluetooth-muted = "󰅶 {format_source}";
      format-source       = "";
      format-source-muted = "";
      # format-icons.headphone = "";
    };
    # TODO: hmmm.... pipewire?
    pulseaudio.on-click = "pavucontrol";

    temperature.format = "{temperatureC}°";
    # tranticicero
    temperature.hmwon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input";

    # orders
    tray.space = 10;
  };

  programs.waybar.settings.mainBar.style = /* css */ ''
    * {
      font-family: monospace;
      font-size: 10pt;
    }
  '';
}
