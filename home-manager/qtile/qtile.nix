{ config, pkgs, ... }:

{
  # Установка Qtile и зависимостей
  home.packages = with pkgs; [
    (python312Packages.qtile.override { withWayland = true; }) # Qtile с Wayland
    python312Packages.pywlroots # Wayland-протоколы для Qtile
    python312Packages.pywayland # Wayland-поддержка
    python312Packages.xkbcommon # Управление клавиатурой
    wlroots # Wayland-композитор
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
    Exec=${pkgs.python312Packages.qtile}/bin/qtile start -b wayland
    Type=Application
    DesktopNames=qtile
    Keywords=wm;tiling
  '';

  # Переменные окружения для Qtile
  home.sessionVariables = {
    QTILE_BACKEND = "wayland"; # Убедиться, что Qtile использует Wayland
  };
}
