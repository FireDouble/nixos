{
  pkgs,
  inputs,
  lib,
  modulesPath,
  ...
}: {
  nix = {
    package = pkgs.lix;
    settings = {
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

    ../../modules/nixos/services/default.nix
    ../../modules/nixos/system/default.nix

    ../../modules/nixos/themes/catppuccin.nix
  ];

  zram.enable = lib.mkForce false;
  locales.enable = lib.mkForce false;


  programs = {
    fish.enable = true;
    direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Cli tools
    git
    neovim

    # Apps
    gparted
    vesktop
    vscode

    # The installers
    arch-install-scripts # Arch
    dnf5 # Fedora
    debootstrap # Debin and ubuntu
    apt # Ubuntu
  ];

  ###############
  # DANGER ZONE #
  ###############

  networking = {
    hostName = "artemis";
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;
  };

  time.timeZone = "Europe/Warsaw";

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  system.stateVersion = "24.05";
}
