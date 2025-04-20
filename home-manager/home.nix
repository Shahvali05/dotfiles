{ pkgs, ... }: {
  imports = [
    ./nvim/neovim.nix
  ];
  home.username = "laraeter";
  home.homeDirectory = "/home/laraeter";
  home.stateVersion = "24.11";

  # Пакеты для пользователя
  home.packages = with pkgs; [
    brave
    lazydocker
    mako
    libnotify
    mpv
  ];

  home.file = {
  };

  services.mako = {
    enable = true;
    # Основные параметры
    anchor = "top-right"; # Уведомления в правом верхнем углу
    defaultTimeout = 3000; # 3 секунды
    backgroundColor = "#2e344099"; # Серо-синий с прозрачностью 80% (99 в hex = ~0.6 alpha)
    textColor = "#d8dee9"; # Светлый текст для контраста
    borderColor = "#4c566a"; # Граница чуть темнее
    borderSize = 2; # Толщина границы
    borderRadius = 5; # Скругленные углы для красоты
    font = "Sans 10"; # Минималистичный шрифт
    width = 300; # Ширина уведомления
    height = 100; # Высота уведомления
    padding = "10"; # Внутренние отступы
    margin = "10"; # Внешние отступы от края экрана
    layer = "overlay"; # Уведомления поверх всего
    # Звуковая настройка
    extraConfig = ''
      [urgency=normal]
      on-notify=exec mpv ${pkgs.sound-theme-elementary}/share/sounds/elementary/stereo/message-new-instant.wav
    '';
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
