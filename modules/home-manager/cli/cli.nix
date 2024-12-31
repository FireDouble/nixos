{ lib, ... }:

{
  imports = [
    ./nixvim.nix
    ./fish.nix
    ./starship.nix
    ./nh.nix
  ];

  nh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
}
