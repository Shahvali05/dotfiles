{ config, pkgs, ... }:

{
  services.dbus.enable = true;
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      local   all   all   trust
      host    all   all   127.0.0.1/32   trust
      host    all   all   ::1/128        trust
    '';
  };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Ensure Wayland support
    theme = "${pkgs.sddm-sugar-candy-theme}"; # Optional: A modern theme
  };

  # Add Qtile and Hyprland to system packages
  environment.systemPackages = with pkgs; [
    qtile.override { withWayland = true; } # Qtile with Wayland backend
    hyprland # Hyprland compositor
    # Dependencies for Qtile Wayland
    pywlroots
    pywayland
    python-xkbcommon
    wlroots
    # Optional utilities for Wayland
    waybar
    wofi
  ];

  # Define Wayland session files for Qtile and Hyprland
  environment.etc = {
    # Qtile Wayland session
    "xdg/wayland-sessions/qtile.desktop".text = ''
      [Desktop Entry]
      Name=Qtile (Wayland)
      Comment=Qtile Tiling Window Manager (Wayland)
      Exec=${pkgs.qtile}/bin/qtile start -b wayland
      Type=Application
      DesktopNames=qtile
      Keywords=wm;tiling
    '';

    # Hyprland Wayland session (already provided by Hyprland package, but included for clarity)
    "xdg/wayland-sessions/hyprland.desktop".text = ''
      [Desktop Entry]
      Name=Hyprland
      Comment=Hyprland Wayland Compositor
      Exec=${pkgs.hyprland}/bin/Hyprland
      Type=Application
      DesktopNames=Hyprland
      Keywords=wm;tiling
    '';
  };

  # Ensure XWayland is available for compatibility
  programs.xwayland.enable = true;
}
