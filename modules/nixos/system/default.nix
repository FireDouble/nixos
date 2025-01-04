{lib, ...}: {
  imports = [
    ./locales.nix
    ./systemd-boot.nix
    ./zram.nix
  ];

  locales.enable = true;
  systemd-boot.enable = true;
  zram.enable = true;
}
