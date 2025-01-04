{lib, ...}: {
  imports = [
    ./steam.nix
    ./hrl.nix
  ];

  hrl.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault true;
}
