{
  pkgs-stable,
  user,
  ...
}:

{
  # Enable libvirt daemon
  virtualisation = {
    docker.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd = {
      qemu.vhostUserPackages = with pkgs-stable; [ virtiofsd ];
      enable = true;
      qemu = {
        package = pkgs-stable.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = true;

  # Add user to the libvirtd group
  users.users.${user.username} = {
    extraGroups = [
      "libvirtd"
      "docker"
    ];
  };

  # Enable UEFI firmware support
  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs-stable.qemu}/share/qemu/firmware"
  ];
}
