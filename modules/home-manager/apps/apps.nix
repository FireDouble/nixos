{lib, ...}: {
  imports = [
    ./firefox/firefox.nix
    ./wezterm/wezterm.nix
  ];

  firefox.enable = lib.mkDefault true;
  wezterm.enable = lib.mkDefault true;
}
