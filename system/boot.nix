{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelPackages = pkgs.linuxPackages_7_0;
  
  boot.kernelModules = [ "binder_linux" "ashmem_linux" "fuse" ];
  boot.kernelParams = [
    "iommu=pt"
    "intel_iommu=on" # amd_iommu=on
    "cgroup_enable=memory"
    "swapaccount=1"
  ];
}
