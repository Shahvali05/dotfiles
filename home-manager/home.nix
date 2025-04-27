{ pkgs, ... }: {
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
    (dwl.override {
      conf = builtins.readFile "${config.homeDirectory}/nixos/home-manager/dwl/config.h";
    })
    wget
    brave
    lazydocker
    docker-compose
    mako
    libnotify
    mpv
    remmina
    python312Packages.bpython
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
}
