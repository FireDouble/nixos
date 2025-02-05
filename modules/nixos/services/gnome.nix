{
  lib,
  config,
  ...
}: {
  options = {
    gnome.enable = lib.mkEnableOption "Enable gnome and gdm";
  };

  config = lib.mkIf config.gnome.enable {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}
