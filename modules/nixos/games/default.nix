{lib, ...}: {
  imports = [
    ./steam.nix
    ./honkersRL.nix
  ];

  honkers.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
}
