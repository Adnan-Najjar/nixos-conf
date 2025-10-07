{
  config,
  pkgs,
  user,
  ...
}:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    # Automatically run nix store garbage collector
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Automatically run nix store optimiser
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user.username} = {
      isNormalUser = true;
      description = "${user.fullName}";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
  };

  # Enable Programs
  programs = {
    zsh.enable = true;
    gnupg.agent = {
      pinentryPackage = pkgs.pinentry-gtk2;
      enable = true;
      enableSSHSupport = true;
      settings = {
        default-cache-ttl = 60480000;
        default-cache-ttl-ssh = 60480000;
        max-cache-ttl = 60480000;
      };
    };
  };

  # List services that you want to enable:
  # services.openssh.enable = true;
}
