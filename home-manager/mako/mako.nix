{ pkgs, inputs, ... }:

{
  programs.mako = {
    enable = true;  # включает mako (устанавливает пакет и запускает daemon)
    settings = {
      anchor = "top-right";    # позиционирование уведомлений
      border-radius = 8;        # радиус скругления углов

      background-color = "#445577CC";  # цвет фона (CC = ~0.8 прозрачности)
      text-color       = "#FFFFFFFF";  # цвет текста (здесь — белый непрозрачный)

      default-timeout  = 5000;   # время (мс) показа уведомления, 0 = бесконечно
      ignore-timeout   = false;  # использовать указанный default-timeout
    };
  };
}
