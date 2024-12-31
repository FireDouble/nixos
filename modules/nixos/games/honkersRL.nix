{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.aagl.nixosModules.default];
  options = {
    honkers.enable = lib.mkEnableOption "Enable Honkers Railway Launcher";
  };

  config = lib.mkIf config.honkers.enable {
    nix.settings = inputs.aagl.nixConfig; # Set up Cachix
    programs.honkers-railway-launcher.enable = true;
    programs.wavey-launcher.enable = true;
  };
}
