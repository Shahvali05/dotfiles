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

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";

  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [
      qtile-extras
    ];
    wrapperFeatures.gtk = true; # Для GTK-приложений
    extraSessionCommands = ''
      export XKB_DEFAULT_LAYOUT=us,ru
      export XKB_DEFAULT_OPTIONS=grp:caps_toggle,caps:none
    '';
  };

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:caps_toggle,caps:none";
  };

  # Создание пользовательского XKB-файла для настройки Caps Lock
  environment.etc."xkb/symbols/custom".text = ''
    xkb_symbols "custom" {
        include "us"
        include "ru"
        key <CAPS> { [ ISO_Next_Group ] }; // Caps Lock переключает раскладку
        modifier_map Lock { <CAPS> };
    };
  '';

  # Установка пакетов, если нужно (например, wev для отладки)
  environment.systemPackages = with pkgs; [
    wev # Для отладки событий клавиш в Wayland
  ];
}
