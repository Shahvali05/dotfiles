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
in {
  imports = [
    ./nvim/neovim.nix
    ./mako/mako.nix
    # ./qtile/qtile.nix
  ];
  home.username = "laraeter";
  home.homeDirectory = "/home/laraeter";
  home.stateVersion = "24.11";


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

    eww
    jq
    socat
    lm_sensors
  ];

  home.file = {
  };

  home.sessionVariables = {
    # XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  # programs.eww = {
  #   enable = true;
  #   configDir = ./eww;  # путь к конфигурации
  # };
}
