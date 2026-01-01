{
  config,
  pkgs-unstable,

  lib,
  ...
}:
{

  services.ollama = {
    enable = true;
    package = pkgs-unstable.ollama-cuda;
    acceleration = "cuda";
    # if ollama not using GPU run:
    # sudo modprobe --remove nvidia-uvm
    # sudo modprobe nvidia-uvm
  };

  # Run opencode with ollama
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
  };

  home.file = {
    "${config.home.homeDirectory}/.config/opencode/agent".source = ./agent;
    "${config.home.homeDirectory}/.config/opencode/opencode.json".source = ./opencode.json;
  };

  systemd.user.services.opencode-web = {
    Unit = {
      Description = "Start opencode web at startup";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs-unstable.opencode} serve --port 2077";
    };
  };
}
