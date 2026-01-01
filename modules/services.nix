{ lib, ... }:

{
  # List services that you want to enable:
  services.openssh = {
    enable = true;
    openFirewall = false; # don't open firewall port
  };

  services.tailscale = {
    enable = true;
    extraSetFlags = [ "--netfilter-mode=nodivert" ];
    extraDaemonFlags = [ "--no-logs-no-support" ];
  };

  services.fcron.enable = true;

  services.stirling-pdf = {
    enable = true;
    environment = {
      SERVER_PORT = 2020;
    };
  };
  systemd.services.stirling-pdf.wantedBy = lib.mkForce [ ];
}
