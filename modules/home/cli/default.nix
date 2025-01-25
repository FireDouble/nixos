{lib, ...}: {
  imports = [
    ./nvf.nix
    ./fish.nix
    ./starship.nix
    ./nh.nix
  ];

  nvf.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
}
