{ pkgs, inputs, ... }:

{
  services.mako = {
    enable = true;  # включает mako (устанавливает пакет и запускает daemon)
    anchor = "top-right";    # позиционирование уведомлений
    borderRadius = 8;        # радиус скругления углов
    backgroundColor = "#445577CC";  # цвет фона (CC = ~0.8 прозрачности)
    textColor = "#FFFFFFFF";  # цвет текста (здесь — белый непрозрачный)
    defaultTimeout = 5000;   # время (мс) показа уведомления, 0 = бесконечно
    ignoreTimeout = false;  # использовать указанный default-timeout
  };
}
