{lib, ...}: {
  imports = [
    ./firefox/firefox.nix
    ./lf/lf.nix
    ./wezterm/wezterm.nix
  ];

  firefox.enable = lib.mkDefault true;
  lf.enable = lib.mkDefault true;
  wezterm.enable = lib.mkDefault true;
}
