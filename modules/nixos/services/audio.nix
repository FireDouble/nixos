{
  lib,
  config,
  ...
}: {
  options = {
    audio.enable = lib.mkEnableOption "Enable system audio";
  };

  config = lib.mkIf config.audio.enable {
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
      pulseaudio.enable = false;
    };
    security.rtkit.enable = true;
  };
}
