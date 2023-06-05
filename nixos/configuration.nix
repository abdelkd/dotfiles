# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager   

    ./hardware-configuration.nix
    ./services.nix
  ];

  # boot.kernelPackages = pkgs.linuxKe

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # FIXME: Add the rest of your current configuration

  time.timeZone = "Africa/Algiers";
  
  fonts = {
    enableDefaultFonts = true;
    fontconfig.enable = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      iosevka-bin
    ];
  };

  # internalisation
  i18n = {
    inputMethod.enabled = "fcitx5";
    defaultLocale = "en_US.UTF-8";
  };
  console = {
    font = "Lat-Terminux16";
    useXkbConfig = true;
  };

  hardware.enableAllFirmware = true;

  # enable pulseaudio, bluetooth and blueman
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  hardware.bluetooth.powerOnBoot = true;

  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    # XOrg packages
    xorg.xorgserver
    xorg.xf86inputevdev
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xf86videointel
    xorg.xf86videoati
    xorg.xf86videonouveau
    xorg.xmodmap
    xorg.libXft
    xclip

    nix-prefetch
    sxhkd
    git
    wget
    vim
    wirelesstools neofetch
    rustup
  ];


  # DONE: Set your hostname
  networking.networkmanager = {
    enable = true;
    # wifi.backend= "iwd";
  };
  networking = {

    dhcpcd.enable = false;
    hostName = "nixos";
    nameservers = ["1.1.1.1" "9.9.9.9"];
    enableIPv6 = false;
    useNetworkd = true;

    # Proxy settings
  };

  # DONE: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
      useOSProber = true;

      efiSupport = false;
    };
  };

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    kareem = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "audio" "networkmanager" "bluetooth" ];
    };
  };

  systemd.services = {
    systemd-udev-settle.enable = true;
    NetworkManager-wait-online.enable = false;
    journald = {
      serviceConfig = {
        SystemMaxFileSize = "50M";
        Storage="volatile";
      };
    };

  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };


  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh = {
    enable = true;
    };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
