{ config, ... }:

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
}
