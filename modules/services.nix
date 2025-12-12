{ ... }:

{
  # List services that you want to enable:
  # services.openssh.enable = true;
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
}
