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
    cool-retro-term
    wine

    eww
    jq
    socat
    lm_sensors

    myDwl
  ];

  home.file = {
    "status.sh" = {
      source = ./scripts/status.sh;
      executable = true; # чтобы можно было запускать
    };
  };

  home.sessionVariables = {
    PATH = "$HOME/.local/bin:${pkgs.coreutils}/bin:${pkgs.bash}/bin:$PATH";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    EDITOR = "zed";
  };

  programs.home-manager.enable = true;

  # programs.eww = {
  #   enable = true;
  #   configDir = ./eww;  # путь к конфигурации
  # };
}
