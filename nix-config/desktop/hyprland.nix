{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    waybar
    swww
    hyprlock
    wofi
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
}
