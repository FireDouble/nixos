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
    home.packages = [
      inputs.wezterm.packages.${pkgs.system}.default

      pkgs.nerd-fonts.jetbrains-mono
    ];

    xdg.configFile."wezterm".source = ./config;
  };
}
