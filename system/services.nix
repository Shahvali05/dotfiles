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

  # Включение XWayland для совместимости
  programs.xwayland.enable = true;

  # Опционально: сессия Hyprland (обычно предоставляется пакетом hyprland)
  environment.etc."xdg/wayland-sessions/hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=Hyprland Wayland Compositor
    Exec=${pkgs.hyprland}/bin/Hyprland
    Type=Application
    DesktopNames=Hyprland
    Keywords=wm;tiling
  '';
}
