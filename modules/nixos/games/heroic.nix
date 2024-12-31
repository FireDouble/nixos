{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    heroic.enable = lib.mkEnableOption "Enable Heroic Launcher";
  };

  config = lib.mkIf config.heroic.enable {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
