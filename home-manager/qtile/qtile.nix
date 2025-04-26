{ config, pkgs, ... }:

{
  # Включение Qtile с поддержкой Wayland
  programs.qtile = {
    enable = true;
    package = pkgs.qtile.override { withWayland = true; }; # Wayland-бэкенд
    configFile = ./config.py; # Ссылка на config.py
  };

  # Пакеты для Qtile Wayland
  home.packages = with pkgs; [
    pywlroots
    pywayland
    python-xkbcommon
    wlroots
    foot # Wayland-терминал
    wofi # Запуск приложений
  ];

  # Копирование конфигурации Qtile
  xdg.configFile."qtile/config.py".source = ./config.py;

  # Создание пользовательской сессии Qtile для Wayland
  xdg.dataFile."wayland-sessions/qtile.desktop".text = ''
    [Desktop Entry]
    Name=Qtile (Wayland)
    Comment=Qtile Tiling Window Manager (Wayland)
    Exec=${pkgs.qtile}/bin/qtile start -b wayland
    Type=Application
    DesktopNames=qtile
    Keywords=wm;tiling
  '';

  # Переменные окружения для Qtile
  home.sessionVariables = {
    QTILE_BACKEND = "wayland"; # Убедиться, что Qtile использует Wayland
  };
}
