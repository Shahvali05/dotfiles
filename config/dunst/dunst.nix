{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "keyboard";
        markup = "full";
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:";
        font = "Iosevka Nerd Font 12"; # Можно заменить на любой шрифт по вкусу
        geometry = "400x80-30+30";     # Размер и расположение уведомлений
        #transparency = 0.9;            # Прозрачность
        frame_width = 2;               # Толщина рамки
        separator_height = 2;          # Высота разделителя между уведомлениями
        frame_color = "#3b4252";       # Цвет рамки
        icon_position = "left";        # Позиция иконок
      };

      urgency_low = {
        timeout = 5;
        background = "#2E3440";        # Цвет фона для уведомлений низкого приоритета
        foreground = "#88C0D0";        # Цвет текста
        frame_color = "#4C566A";       # Цвет рамки
      };

      urgency_normal = {
        timeout = 10;
        background = "#3B4252";        # Цвет фона для уведомлений среднего приоритета
        foreground = "#ECEFF4";        # Цвет текста
        frame_color = "#5E81AC";       # Цвет рамки
      };

      urgency_critical = {
        timeout = 15;
        background = "#BF616A";        # Цвет фона для уведомлений высокого приоритета
        foreground = "#ECEFF4";        # Цвет текста
        frame_color = "#D08770";       # Цвет рамки
      };

      shortcuts = {
        context = "mod1+period";       # Показ контекстного меню
        close = "mod1+space";          # Закрытие уведомления
        close_all = "mod1+shift+space";# Закрытие всех уведомлений
        history = "mod1+grave";        # История уведомлений
      };
    };
  };
}

