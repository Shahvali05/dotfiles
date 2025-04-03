{ config, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  virtualisation.lxc.enable = true;
  
  programs.adb.enable = true;
  hardware.opengl.enable = true;
  
  systemd.services.lxcfs.enable = true;
  
  users.extraGroups = {
    vboxusers.members = [ "laraeter" ];
    docker.members = [ "laraeter" ];
  };
}
