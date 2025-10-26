{ config, pkgs, ... }:

{
  imports = [
    ./hardware/hardware-configuration.nix
    ./system/boot.nix
    ./system/network.nix
    ./system/services.nix
    ./system/virtualization.nix
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
}
