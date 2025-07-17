{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelModules = [ "binder_linux" "ashmem_linux" "fuse" ];
  boot.kernelParams = [
    "iommu=pt"
    "amd_iommu=on"
    "cgroup_enable=memory"
    "swapaccount=1"
  ];
}
