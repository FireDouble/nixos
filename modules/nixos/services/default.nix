{lib, ...}: {
  imports = [
    ./audio.nix
    ./gnome.nix
  ];

  audio.enable = lib.mkDefault true;
  gnome.enable = lib.mkDefault true;
}
