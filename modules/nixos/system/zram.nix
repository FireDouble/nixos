{
  lib,
  config,
  ...
}: {
  options = {
    zram.enable = lib.mkEnableOption "Enable zramSwap";
  };

  config = lib.mkIf config.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 75;
    };
  };
}
