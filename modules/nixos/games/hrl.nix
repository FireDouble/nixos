{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [inputs.aagl.nixosModules.default];
  options = {
    hrl.enable = lib.mkEnableOption "Enable Honkers Railway Launcher";
  };

  config = lib.mkIf config.hrl.enable {
    nix.settings = inputs.aagl.nixConfig; # Set up Cachix
    programs.honkers-railway-launcher.enable = true;
  };
}
