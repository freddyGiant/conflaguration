{ inputs, ... }: {
  virtualisation.vmVariant = {
    virtualisation.memorySize = 2048;
    virtualisation.cores = 4;
    virtualisation.qemu.options = [ "-vga virtio" "-display sdl,gl=on" ];
  };

  hardware.opengl.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
