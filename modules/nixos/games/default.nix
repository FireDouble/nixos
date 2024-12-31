{lib, ...}: {
  imports = [
    ./steam.nix
    ./heroic.nix
    ./honkersRL.nix
  ];

  honkers.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
  heroic.enable = lib.mkDefault true;
}
