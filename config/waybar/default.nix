{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  # Символические ссылки на файлы Waybar
  home.file.".config/waybar/config".source = ./config.jsonc;
  home.file.".config/waybar/style.css".source = ./style.css;
}
