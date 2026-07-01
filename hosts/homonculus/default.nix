{ config, lib, ... }: {
  virtualisation.vmVariant = {
    # dangerous option
    # services.getty.autologinUser = config.my.username;

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

    # TODO
    # virtualisation.forwardPorts = [
    #   { from = "host"; host.port = 2222; guest.port = 22; }
    #   { from = "host"; host.port = 8080; guest.port = 80; }
    #   { from = "host"; host.port = 5433; guest.port = 5432; }
    # ];

    # this doesn't happen automatically!
    home-manager.users.${config.my.username} = import ../../modules/home;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.11";
}
