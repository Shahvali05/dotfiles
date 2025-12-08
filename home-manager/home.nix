{ pkgs, ... }: 

let
  myPython = pkgs.python312.withPackages (ps: with ps; [
    matplotlib
    bpython
    debugpy
    ipykernel
    jupyter
    ueberzug
  ]);
  myDwl = (pkgs.dwl.override {
    configH = builtins.readFile ./dwl/config.h;
  }).overrideAttrs (old: {
    buildInputs = (old.buildInputs or []) ++ [
      pkgs.fcft
      pkgs.libdrm
      pkgs.pixman
      pkgs.pango
      pkgs.dbus
    ];

    patches = (old.patches or []) ++ [
      ./dwl/patches/mypatch.patch
      # ./dwl/patches/gaps.patch
      # ./dwl/patches/bar-0.7.patch
    ];
  });
in {
  imports = [
    ./nvim/neovim.nix
    ./mako/mako.nix
  ];
  home.username = "red";
  home.homeDirectory = "/home/red";
  home.stateVersion = "25.05";


  # Пакеты для пользователя
  home.packages = with pkgs; [
    # Десктопные приложения
    prismlauncher # minecraft launcher
    brave # браузер
    mpv # воспроизведение видео
    vlc # воспроизведение видео
    remmina # клиент для удаленного доступа
    gimp # графический редактор
    lutris # игры
    zed-editor # IDE
    onlyoffice-desktopeditors # документы
    sqlitebrowser # редактор базы данных
    mangareader # чтение манги
    cool-retro-term # прикольный терминал
    code-cursor # IDE
    protonplus # запускает игры через steam
    zoom-us # для видеоконференций
    fuzzel # аналог rofi
    whatsie # WhatsApp
    photoflare # фото-редактор

    # Утилиты
    vim # редактор кода
    wget # получает файлы из интернета
    lazydocker # docker в терминале
    docker-compose # собирает контейнеры
    conda # окружение python
    myPython # окружение python
    pipe-viewer # Youtube в терминале
    zip # архиватор
    rmtrash # удаляет файлы в корзину
    lsd # лучшее ls
    wine # для запуска exe файлов
    proxychains # прокси
    mangohud # для lutris
    libsForQt5.kdenlive # видео редактор

    # Утилиты для wm
    mako # уведомления
    libnotify # уведомления
    pywalfox-native # установка цветовой схемы
    eww # бар
    jq # обработка json. Нужна была для работы eww скриптов
    socat # нужна была для работы eww скриптов
    lm_sensors # нужна была для работы eww скриптов
    myDwl # dwl
    wbg # for dwl. Установка обоев
    wlr-randr # для мониторов (используется для установки разрешения)
    xdg-desktop-portal # для просмотра файлов
    xdg-desktop-portal-wlr # для просмотра файлов
    orca # не помню зачем
    acpi # не помню зачем
    wob # for dwl. Отображает всплывающую информацию
    light # for dwl. Используется для получения информации о яркости экрана
  ];

  home.file = {
    ".dwl_bar_status.sh" = {
      source = ./dwl/.dwl_bar_status.sh;
      executable = true;
    };
  };

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin:$PATH";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    EDITOR = "zed";
  };

  services.gnome-keyring.enable = true;

  programs.home-manager.enable = true;
}
