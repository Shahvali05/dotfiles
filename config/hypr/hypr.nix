{ config, pkgs, ... }:

let
  hyprConfig = pkgs.writeTextFile {
    name = "hyprland.conf";
    text = builtins.readFile "${config.home.homeDirectory}/nixos/config/hypr/hyprland.conf";
  };
in {
  home.file.".config/hypr/hyprland.conf".source = hyprConfig;
}
