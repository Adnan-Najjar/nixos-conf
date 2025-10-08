{
  config,
  pkgs,
  user,
  ...
}:

{
  # Enable libvirt daemon
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };

  programs.virt-manager.enable = true;

  # Add user to the libvirtd group
  users.users.${user.username} = {
    extraGroups = [ "libvirtd" ];
  };

  # Enable UEFI firmware support
  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
  ];

  # Virt-manager settings
  home-manager.users.${user.username} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
