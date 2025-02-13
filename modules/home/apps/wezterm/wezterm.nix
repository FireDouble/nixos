{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wezterm.enable = lib.mkEnableOption "Enable Wezterm";
  };

  config = lib.mkIf config.wezterm.enable {
    home.packages = with pkgs; [
      wezterm-git

      pkgs.nerd-fonts.jetbrains-mono
    ];

    xdg.configFile."wezterm".source = ./config;
  };
}
