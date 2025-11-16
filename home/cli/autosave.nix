{ pkgs, user, ... }:
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
      ExecStart = pkgs.writeShellScript "autosave" ''
        set -eu
        cd $HOME/Documents

        ${pkgs.git}/bin/git pull --rebase || true
        ${pkgs.git}/bin/git add .
        ${pkgs.git}/bin/git diff --quiet --cached && exit 0
        ${pkgs.git}/bin/git commit -m "Autosave: $(date)"
        ${pkgs.git}/bin/git push || true
      '';
    };
  };
}
