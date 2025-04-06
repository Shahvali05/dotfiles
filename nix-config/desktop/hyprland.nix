{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  
  environment.systemPackages = with pkgs; [
    waybar
    swww
    hyprlock
    wofi
    gdk-pixbuf
    shared-mime-info
    hicolor-icon-theme
    adwaita-icon-theme
    hyprpicker
    xdg-desktop-portal-hyprland
  ];
}
