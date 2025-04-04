{pkgs, ...}: {
  imports = [
    ../../modules/home/apps
    ../../modules/home/cli
    ../../modules/home/desktop
  ];

  home.packages = with pkgs; [
    # Service GUIs
    pavucontrol
    blueman

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
    # prismlauncher
    # heroic
    bottles
    vscode
    gimp
    anki
    vesktop-git
    stremio

    aseprite
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
