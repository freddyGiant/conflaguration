# TODO: privacy?
{ pkgs, homeSources, ... }: {
  programs.waybar.enable = true;
  programs.waybar.package = homeSources.waybar-master.packages.${pkgs.stdenv.hostPlatform.system}.default;
  # programs.waybar.package = pkgs.waybar.overrideAttrs (old: {
  #   version = "git-${homeSources.waybar-master.shortRev or "unknown"}";
  #   src = homeSources.waybar-master;
  #
  #   nativeBuildInputs = (old.nativeBuildInputs or []) ++ (with pkgs; [
  #     cmake
  #     wayland-protocols
  #   ]);
  #   buildInputs = (old.buildInputs or []) ++ (with pkgs; [
  #     howard-hinnant-date
  #     fmt
  #     modemmanager
  #     cava
  #     libcava
  #     # glib.dev
  #     # glibmm
  #     # glibmm_2_68
  #     # gtkmm3
  #   ]);
  # });

  programs.waybar.systemd.enable = true;

  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    height = 24;
    spacing = 10;
  };

  programs.waybar.settings.mainBar.modules-left = [ "tray" ];

  programs.waybar.settings.mainBar.tray.ignore-list = [ "nm-applet" "blueman" ];

  programs.waybar.settings.mainBar.modules-center = [ "clock" ];

  programs.waybar.settings.mainBar.clock.format = "{:%H:%M:%S %A %d %B %Y}";
  programs.waybar.settings.mainBar.clock.interval = 1;

  programs.waybar.settings.mainBar.modules-right = [
    "cpu"
    "memory"
    "temperature"
    "power-profiles-daemon"
    "network"
    # "tray#network"
    # "bluetooth"
    # "tray#bluetooth"
    "battery"
    "pulseaudio"
  ];

  programs.waybar.settings.mainBar.cpu.format = "CPU {usage:>3}%";
  programs.waybar.settings.mainBar.cpu.interval = 2;

  programs.waybar.settings.mainBar.memory.format = "RAM {percentage:>3}%";
  programs.waybar.settings.mainBar.memory.interval = 2;

  programs.waybar.settings.mainBar.temperature.format = "{temperatureC:>3}°";
  programs.waybar.settings.mainBar.temperature.hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input"; # tranticicero

  programs.waybar.settings.mainBar."power-profiles-daemon".format-icons = {
    performance = "FGHT";
    balanced    = "BLNC";
    power-saver = "SAVE";
  };

  programs.waybar.settings.mainBar.network = {
    format-wifi         = "{essid:>10.10} {signalStrength:>3}%";
    format-ethernet     =     "       eth 100%";
    format-disconnected =     " localhost ---%";
  };

  # programs.waybar.settings.mainBar."tray#network" = {
  #   ignore-list = [ "blueman" "keepassxc" ];
  # };
  #
  # programs.waybar.settings.mainBar."tray#bluetooth" = {
  #   ignore-list = [ "nm-applet" "keepassxc" ];
  # };

  # programs.waybar.settings.mainBar.bluetooth = {
  #   # format = "---";
  #   format-connected = "{device_alias:>4}";
  #   # format-disabled  = "off";
  #   # format-off       = "off";
  # };

  programs.waybar.settings.mainBar.pulseaudio = {
    format                 = "{volume:>3}%   {format_source}";
    format-muted           =         "MUTE   {format_source}"; # 󰸈
    format-bluetooth       = "{volume:>3}% B {format_source}"; # 
    format-bluetooth-muted =         "MUTE B {format_source}";
    format-source       = "LIVE"; # 
    format-source-muted = "MUTE"; # 
    # format-icons.headphone = "";
  };
  programs.waybar.settings.mainBar.pulseaudio.on-click = "pavucontrol";

  programs.waybar.settings.mainBar.battery = {
    format          = "{capacity:>3}% -";
    format-plugged  = "{capacity:>3}% ~";
  };
  programs.waybar.settings.mainBar.battery.states.critical = 12;

  programs.waybar.style = /* css */ ''
    * {
      font-family: monospace;
      font-size: 12pt;
      color: white;
      background-color: black;
    }

    #tray, #clock, #cpu, #memory, #temperature,
    #power-profiles-daemon, #battery, #pulseaudio {
      background: transparent;
      padding: 0 8px;
    }

    #battery.critical:not(.charging) {
      background-color: #f53c3c;
    }
  '';
}
