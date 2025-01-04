{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    steam.enable = lib.mkEnableOption "Enable steam";
  };

  config = lib.mkIf config.steam.enable {
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
