{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    systemd-boot.enable = lib.mkEnableOption "Enable systemd-boot";
  };

  config = lib.mkIf config.systemd-boot.enable {
    boot = {
      tmp.cleanOnBoot = true;
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };

      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
