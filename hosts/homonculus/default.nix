{ config, lib, ... }: {
  virtualisation.vmVariant = {
    services.keyd.enable = lib.mkForce false;
    # users.users.${config.my.username}.initialPassword = "test";

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

    # TODO
    # virtualisation.forwardPorts = [
    #   { from = "host"; host.port = 2222; guest.port = 22; }
    #   { from = "host"; host.port = 8080; guest.port = 80; }
    #   { from = "host"; host.port = 5433; guest.port = 5432; }
    # ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.11";
}
