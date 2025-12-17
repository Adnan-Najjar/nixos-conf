{ pkgs-unstable, lib, ... }:
let
  git = lib.getExe pkgs-unstable.git;
in
{
  systemd.user.timers."autosave" = {
    Unit = {
      Description = "Autosave notes timer";
    };
    Timer = {
      OnCalendar = "hourly";
      Unit = "autosave.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  systemd.user.services."autosave" = {
    Unit = {
      Description = "Autosave notes to git";
    };
    Service = {
      Type = "oneshot";
      ExecStart = pkgs-unstable.writeShellScript "autosave" ''
        set -eu
        cd $HOME/Documents

        ${git} pull --rebase || true
        ${git} add .
        ${git} diff --quiet --cached && exit 0
        ${git} commit -m "Autosave: $(date)"
        ${git} push || true
      '';
    };
  };
}
