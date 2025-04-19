{ pkgs, ... }: {
  home.username = "laraeter";
  home.homeDirectory = "/home/laraeter";
  home.stateVersion = "24.11";

  # Настройка Zsh
  # programs.zsh = {
  #   enable = true;
  #   shellAliases = {
  #     ll = "ls -l";
  #     rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-laraeter";
  #   };
  #   oh-my-zsh = {
  #     enable = true;
  #     theme = "robbyrussell";
  #   };
  # };

  # Настройка Vim
  # programs.vim = {
  #   enable = true;
  #   settings = {
  #     number = true;
  #     tabstop = 2;
  #   };
  # };

  # Пакеты для пользователя
  home.packages = with pkgs; [
    brave
  ];
}
