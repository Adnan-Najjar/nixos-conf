{ ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Environment variables for Nix commands
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # Allow unfree packages for all Nix commands including nix-shell
      accept-flake-config = true;
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
