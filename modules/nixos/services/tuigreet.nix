{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    tuigreet.enable = lib.mkEnableOption "Enable tuigreet";
  };

  config = lib.mkIf config.gnome.enable {
    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = let
            tuigreet = "${lib.getExe pkgs.greetd.tuigreet}";
            baseSessionsDir = "${config.services.displayManager.sessionData.desktops}";
            xSessions = "${baseSessionsDir}/share/xsessions";
            waylandSessions = "${baseSessionsDir}/share/wayland-sessions";
            tuigreetOptions = [
              "--remember"
              "--remember-session"
              "--sessions ${waylandSessions}:${xSessions}"
              "--time"
            ];
            flags = lib.concatStringsSep " " tuigreetOptions;
          in {
            command = "${tuigreet} ${flags}";
            user = "greeter";
          };
        };
      };
    };
  };
}

