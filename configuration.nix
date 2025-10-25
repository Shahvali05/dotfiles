{ config, pkgs, ... }:

{
  imports = [
    ./hardware/hardware-configuration.nix
    ./system/boot.nix
    ./system/network.nix
    ./system/virtualization.nix
    ./system/services.nix
    ./desktop/display.nix
    ./desktop/hyprland.nix
    ./desktop/fonts.nix
    ./users/users.nix
    ./packages/system-packages.nix
    ./packages/dev-tools.nix
  ];

  nix.gc = {
    automatic = true; # Включить автоматическую очистку
    dates = "weekly"; # Запускать раз в неделю
    options = "--delete-older-than 30d"; # Удалять поколения старше 30 дней
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";


  # Установим dwl
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
