# Edit this configuration file to" define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  inputs,
  pkgs,
  user,
  ...
}:

{
  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking.hostName = "${user.hostname}";
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dubai";

  # Select internationalisation properties.
  i18n = {
    supportedLocales = [
      "ar_AE.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
    defaultLocale = "en_US.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (
    with pkgs;
    [
      cheese # Webcam app
      snapshot # Camera app
      simple-scan # Scanner utility
      geary # Email reader
      evince # Document viewer
      yelp # Help viewer
      epiphany # Web browser
      orca # Screen reader
      seahorse # Passwords and keys
      gnome-connections
      gnome-console
      gnome-photos
      gnome-tour
      gnome-user-docs
      gnome-maps
      gnome-contacts
      gnome-software
      gnome-logs
      gnome-music
    ]
  );

  # Disable CUPS for printing
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable Bluetooth

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # System-wide packages
  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    tesseract
    wl-clipboard
    chromium
    onlyoffice-desktopeditors
  ];

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
      };
    };
    packages = [ pkgs.nerd-fonts.caskaydia-cove ];
  };

  # Network Configuration
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system = {
    stateVersion = "25.05"; # Do not change this
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-25.05";
  };
}
