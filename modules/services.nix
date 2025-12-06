{ config, lib, pkgs, ... }:

{
  # List services that you want to enable:
  # services.openssh.enable = true;
  services.fcron.enable = true;

  services.stirling-pdf = {
    enable = true;
    environment = {
      SERVER_PORT = 2020;
    };
  };
}
