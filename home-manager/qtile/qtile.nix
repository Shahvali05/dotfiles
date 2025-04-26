{ config, pkgs, ... }:

{
  # Enable Qtile with Wayland support
  programs.qtile = {
    enable = true;
    package = pkgs.qtile.override { withWayland = true; }; # Ensure Wayland backend
    configFile = ./config.py; # Reference to your Qtile config file
  };

  # Install additional dependencies required for Qtile Wayland
  home.packages = with pkgs; [
    # Wayland-specific dependencies
    pywlroots
    pywayland
    python-xkbcommon
    wlroots
    # Optional: Utilities for Wayland compositors
    waybar # For a status bar
    wofi # For a Wayland-compatible application launcher
    kanshi # For output management (e.g., multi-monitor setups)
  ];

  # Ensure Qtile config file is managed
  xdg.configFile."qtile/config.py".source = ./config.py;

  # Optional: Set session variables specific to Qtile Wayland
  home.sessionVariables = {
    QTILE_BACKEND = "wayland"; # Explicitly set Qtile to use Wayland
  };
}
