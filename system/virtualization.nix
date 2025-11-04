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
  virtualisation.libvirtd.enable = true;
  
  programs.adb.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-vaapi-driver
    intel-media-driver  # Для видео/декодирования
    vulkan-loader
    vulkan-tools
    vpl-gpu-rt  # Для новых GPU (Alder Lake+)
  ];
  hardware.graphics.extraPackages32 = with pkgs; [
    pkgsi686Linux.intel-vaapi-driver
    pkgsi686Linux.vulkan-loader
  ];
  hardware.xone.enable = true;
  systemd.services.lxcfs.enable = true;
  
  users.extraGroups = {
    vboxusers.members = [ "red" ];
    docker.members = [ "red" ];
    libvirtd.members = [ "red" ];
    waydroid.members = [ "red" ];
  };
}
