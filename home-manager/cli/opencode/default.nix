{ config, pkgs, ... }:
{

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    acceleration = "cuda";
    # if ollama not using GPU run:
    # sudo modprobe --remove nvidia-uvm
    # sudo modprobe nvidia-uvm
  };

  # Run opencode with ollama
  programs.opencode.enable = true;

  home.file = {
    "${config.home.homeDirectory}/.config/opencode/agent".source = ./agent;
    "${config.home.homeDirectory}/.config/opencode/opencode.json".source = ./opencode.json;
  };
}
