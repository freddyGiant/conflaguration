{ inputs, ... }: {
  virtualisation.memorySize = 2048;
  virtualisation.cores = 4;
  virtualisation.qemu.options = [ "-vga virtio" "-display sdl,gl=on" ];

  hardware.opengl.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
