{ config, pkgs, ... }:

{
  # Enable Programs
  programs = {
    zsh.enable = true;
    nix-ld.enable = true;
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
}
