{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    waybar
    swww
    hyprlock
    hypridle
    wofi
    shared-mime-info
    adwaita-icon-theme
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
}
