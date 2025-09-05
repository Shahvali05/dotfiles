{ config, pkgs, ... }:

let
  myCustomDwlPackage = (pkgs.dwl.override {
    configH = ./overlays/dwl/config.h;
  }).overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ [
        ./overlays/dwl/patches/bar-0.7.patch
      ];
      buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.fcft
        pkgs.libdrm
        pkgs.pixman
        pkgs.pango
      ];
  });

  dwlWithDwlbWrapper = pkgs.writeScriptBin "dwl-with-dwlb" ''
    #!/bin/sh
    exec $(lib.getExe myCustomDwlPackage) -s "${pkgs.dwlb}/bin/dwlb -font \"monospace:size=16\"" "$@"
  ''
in

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
  system.stateVersion = "24.11";


  # Установим dwl
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
}
