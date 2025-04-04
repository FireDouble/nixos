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

      maple-mono.variable
      maple-mono.NF
    ];

    xdg.configFile."wezterm".source = ./config;
  };
}
