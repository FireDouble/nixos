{lib, ...}: {
  imports = [
    ./audio.nix
    ./gnome.nix
    ./tuigreet.nix
  ];

  audio.enable = lib.mkDefault true;
  gnome.enable = lib.mkDefault true;
  tuigreet.enable = lib.mkDefault true;
}
