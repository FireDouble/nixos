{
  pkgs,
  inputs,
  lib,
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
  
  nixpkgs.overlays = [
    inputs.haipkgs.overlays.default
  ];
  
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/services
    ../../modules/nixos/system

    ../../modules/nixos/themes/catppuccin.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  gnome.enable = lib.mkForce false;
  zram.enable = lib.mkForce false;

  programs = {
    fish.enable = true;
    direnv.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  ###############
  # DANGER ZONE #
  ###############

  networking = {
    hostName = "hermes";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  users.users.shizu = {
    isNormalUser = true;
    description = "Shizu";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = "bak";
    users = {
      shizu = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
