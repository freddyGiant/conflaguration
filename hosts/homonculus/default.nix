{ config, lib, ... }: {
  virtualisation.vmVariant = {
    # dangerous option
    services.getty.autologinUser = config.my.username;

    virtualisation.memorySize = 2048;
    virtualisation.cores = 4;
    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display sdl,gl=on"
    ];

    hardware.graphics.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    home-manager.users.${config.my.username} = import ../../modules/home;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.11";
}
