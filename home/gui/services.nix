{ config, ... }:
{
  systemd.user.services.gopray = {
    Unit = {
      Description = "Start GoPray at startup";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${config.home.homeDirectory}/.local/bin/gopray";
      User = config.home.username;
    };
  };
}
