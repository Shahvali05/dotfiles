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
    ./nvim
    # ./mako
    ./niri
  ];
  home.username = "red";
  home.homeDirectory = "/home/red";
  home.stateVersion = "25.05";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

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
    protonplus # запускает игры через steam
    zoom-us # для видеоконференций
    fuzzel # аналог rofi
    photoflare # фото-редактор
    nautilus # файловый менеджер
    pomodoro-gtk # таймер
    dbeaver-bin # для работы с базами данных
    insomnia # для работы с api
    evince # для чтения pdf
    waydroid-helper # для работы с android
    cage # для работы с android
    (pkgs.vscode.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })

    # Утилиты
    vim # редактор кода
    wget # получает файлы из интернета
    lazydocker # docker в терминале
    lazygit # git в терминале
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
    # libsForQt5.kdenlive # видео редактор
    glava # audio spectrum visualizer (for qtile)
    conky # system monitor (for qtile)
    feh # wallpaper manager (for qtile)
    picom # compositor (for qtile)
    claude-code # ИИ агент
    poppler # нужна для отрисовки обложки pdf в файловом менеджере

    # Утилиты для wm
    libnotify # уведомления
    pywalfox-native # установка цветовой схемы
    eww # бар
    jq # обработка json. Нужна была для работы eww скриптов
    socat # нужна была для работы eww скриптов
    lm_sensors # нужна была для работы eww скриптов
    myDwl # dwl
    wbg # for dwl. Установка обоев
    wlr-randr # для мониторов (используется для установки разрешения)
    orca # не помню зачем
    acpi # не помню зачем
    wob # for dwl. Отображает всплывающую информацию
    light # for dwl. Используется для получения информации о яркости экрана
    wofi
    adwaita-icon-theme
    slurp
  ];

  home.file = {
    ".dwl_bar_status.sh" = {
      source = ./dwl/.dwl_bar_status.sh;
      executable = true;
    };
  };

  home.sessionVariables = {
    # XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "wlroots";
    # WAYLAND_DISPLAY = "wayland-0";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    EDITOR = "zed";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Автоматическая разблокировка keyring
  # services.gnome-keyring.enable = true;

  programs.home-manager.enable = true;
}
