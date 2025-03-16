{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    swww
    swaylock
    wofi
    hyprpicker
    xdg-desktop-portal-hyprland
  ];

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
}
