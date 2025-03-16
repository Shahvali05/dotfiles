{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    waybar
    swww
    swaylock
    wofi
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
}
