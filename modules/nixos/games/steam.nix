{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    steam.enable = lib.mkEnableOption "Enable Steam";
  };

  config = lib.mkIf config.steam.enable {
    environment.systemPackages = with pkgs; [
      protonup-qt
    ];

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
      gamemode.enable = true;
    };

    hardware = {
      opentabletdriver.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
