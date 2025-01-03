{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/apps/apps.nix
    ../../modules/home-manager/cli/cli.nix
    ../../modules/home-manager/desktop/desktop.nix
  ];

  home.packages = with pkgs; [
    # Service GUIs
    pavucontrol
    blueman
    gnome-control-center

    # Desktop
    swww
    catppuccin-cursors.mochaLavender
    nwg-look

    # Cli tools
    alejandra
    git
    unzip
    fastfetch

    # Apps
    prismlauncher
    # heroic
    vscode
    vesktop
    gimp
    anki
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
