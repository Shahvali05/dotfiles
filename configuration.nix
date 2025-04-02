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
}
