{ lib, ... }: {
  virtualisation.vmVariant = {
    # dangerous option
    services.getty.autologinUser = config.my.username;

    virtualisation.memorySize = 2048;
    virtualisation.cores = 4;
    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display sdl,gl=on"
      "-vga virtio"
    ];

    # hardware.graphics.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.11";
}
