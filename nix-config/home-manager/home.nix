{ pkgs, ... }: {
  imports = [
    ./nvim/neovim.nix
  ];
  home.username = "laraeter";
  home.homeDirectory = "/home/laraeter";
  home.stateVersion = "24.11";

  # Пакеты для пользователя
  home.packages = with pkgs; [
    codeium
    brave
  ];

  home.file = {
  };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    # EDITOR = "emacs";
  };

  # programs.home-manager.enable = true;
}
