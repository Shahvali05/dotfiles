{ config, pkgs, ... }:

{
  # virtualbox
  virtualisation.virtualbox.host.enable = true;

  # docker
  virtualisation.docker.enable = true;

  # waydroid
  virtualisation.waydroid.enable = true;
  virtualisation.lxc.enable = true;

  # virt-manager
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };
  
  programs.adb.enable = true;
  hardware.graphics.enable = true;
  hardware.xone.enable = true;
  systemd.services.lxcfs.enable = true;
  
  users.extraGroups = {
    vboxusers.members = [ "laraeter" ];
    docker.members = [ "laraeter" ];
    libvirtd.members = [ "laraeter" ];
    waydroid.members = [ "laraeter" ];
  };
}
