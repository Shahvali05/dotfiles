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
    # ./qtile/qtile.nix
  ];
  home.username = "red";
  home.homeDirectory = "/home/red";
  home.stateVersion = "25.05";


  # Пакеты для пользователя
  home.packages = with pkgs; [
    prismlauncher
    wget
    brave
    lazydocker
    docker-compose
    mako
    libnotify
    mpv
    remmina
    conda
    myPython
    gimp
    lutris
    pipe-viewer
    proxychains
    zip
    zed-editor
    onlyoffice-desktopeditors
    sqlitebrowser
    pywalfox-native
    rmtrash
    lsd
    mangareader
    cool-retro-term
    wine

    eww
    jq
    socat
    lm_sensors
    wbg

    myDwl
    wlr-randr
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    protonplus
    zoom-us
  ];

  home.file = {
    "status.sh" = {
      source = ./scripts/status.sh;
      executable = true;
    };
  };

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin:$PATH";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    EDITOR = "zed";
  };

  programs.home-manager.enable = true;

  systems.x86_64-linux = nixosSystem {
    # ...
    modules = [
      ({ pkgs, inputs, ... }: let
          sddmTheme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
            theme = "rei";  # выбор конфигурации из темы (например, “rei”)
          };
        in {
          environment.systemPackages = [
            sddmTheme
            sddmTheme.test  # опционально — скрипт тестирования
          ];

          # нужны qt зависимости
          # (возможно уже включены, но можно явно)
          qt.enable = true;

          services.displayManager.sddm = {
            package = pkgs.kdePackages.sddm;  # убедись, что используешь версию с Qt6
            enable = true;
            theme = sddmTheme.pname;
            extraPackages = sddmTheme.propagatedBuildInputs;  # зависимости темы
            settings = {
              General = {
                GreeterEnvironment = "QML2_IMPORT_PATH=${sddmTheme}/share/sddm/themes/${sddmTheme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
                InputMethod = "qtvirtualkeyboard";
              };
            };
          };
        })
    ];
  };

}
