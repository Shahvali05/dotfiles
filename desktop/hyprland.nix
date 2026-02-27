{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    waybar
    swww
    hyprlock
    hypridle
    shared-mime-info
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
}
