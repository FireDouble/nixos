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

  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/games/default.nix

    ../../modules/nixos/themes/catppuccin.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  heroic.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    home-manager

    # Desktop
    catppuccin-cursors.mochaLavender
    nwg-look

    # Service gui
    pavucontrol
    blueman

    # Cli tools
    alejandra
    git
    unzip
    fastfetch
    fzf

    # Apps
    prismlauncher
    vscode
    vesktop
    gimp
  ];

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

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nyx";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "09:00";
    randomizedDelaySec = "45min";
  };

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    printing.enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  users.users.shizu = {
    isNormalUser = true;
    description = "Shizu";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = [
    ];
  };

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

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
