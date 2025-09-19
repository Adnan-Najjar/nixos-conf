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
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Install packages for Android environment
  environment.packages = with pkgs; [
  ];

  # Required system state version
  system.stateVersion = "24.05";

  # Terminal settings
  terminal.colors = {
    background = "#1e1e1e";
    foreground = "#d4d4d4";
  };
}
