
{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "keyboard";
        markup = "full";
        font = "Iosevka Nerd Font 10";  # Увеличен размер шрифта
        geometry = "800x160-30+30";     # Увеличены размеры уведомлений
        frame_width = 2;                # Толщина рамки
        separator_height = 4;           # Увеличена высота разделителя
        frame_color = "#3b4252";        # Цвет рамки
        icon_position = "left";         # Позиция иконок
        corner_radius = 20;             # Закруглённые углы
      };

      urgency_low = {
        timeout = 3;
        background = "#2E3440";         # Цвет фона для уведомлений низкого приоритета
        foreground = "#88C0D0";         # Цвет текста
        frame_color = "#4C566A";        # Цвет рамки
        corner_radius = 20;             # Закруглённые углы
      };

      urgency_normal = {
        timeout = 5;
        background = "#3B4252";         # Цвет фона для уведомлений среднего приоритета
        foreground = "#ECEFF4";         # Цвет текста
        frame_color = "#5E81AC";        # Цвет рамки
        corner_radius = 20;             # Закруглённые углы
      };

      urgency_critical = {
        timeout = 8;
        background = "#BF616A";         # Цвет фона для уведомлений высокого приоритета
        foreground = "#ECEFF4";         # Цвет текста
        frame_color = "#D08770";        # Цвет рамки
        corner_radius = 20;             # Закруглённые углы
      };

      shortcuts = {
        context = "mod1+period";        # Показ контекстного меню
        close = "mod1+space";           # Закрытие уведомления
        close_all = "mod1+shift+space"; # Закрытие всех уведомлений
        history = "mod1+grave";         # История уведомлений
      };
    };
  };
}

