{ ... }:
{
  imports = [
    ../../modules/home-manager/apps/apps.nix
    ../../modules/home-manager/cli/cli.nix
    ../../modules/home-manager/desktop/desktop.nix
  ];

  home = {
    username = "shizu";
    homeDirectory = "/home/shizu";
    stateVersion = "24.05";
  };

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
    NIX_REMOTE = "daemon";
  };

  programs.home-manager.enable = true;
}
