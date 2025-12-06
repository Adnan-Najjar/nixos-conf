{
  config,
  pkgs,
  user,
  ...
}:

{
  # Enable libvirt daemon
  virtualisation = {
    docker.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd = {
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = true;

  # Add user to the libvirtd group
  users.users.${user.username} = {
    extraGroups = [ "libvirtd" "docker" ];
  };

  # Enable UEFI firmware support
  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
  ];
}
