{ ... }:
{
  systemd.user.services.gopray = {
    Unit = {
      Description = "Run gopray at startup";
    };
    Service = {
      Type = "simple";
      ExecStart = "/home/adnan/.local/bin/gopray";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
