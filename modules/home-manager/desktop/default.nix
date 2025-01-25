{lib, ...}: {
  imports = [
    ./hypr/hyprland.nix
    ./hypr/hyprlock.nix
    ./ags/ags.nix
  ];

  hyprland.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  ags.enable = lib.mkDefault true;
}
