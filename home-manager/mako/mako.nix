{ pkgs, inputs, ... }:

{
  programs.mako = {
    enable = true;  # включает mako (устанавливает пакет и запускает daemon)
    settings = {
      anchor = "top-right";    # позиционирование уведомлений&#8203;:contentReference[oaicite:14]{index=14} 
      borderRadius = 8;        # радиус скругления углов&#8203;:contentReference[oaicite:15]{index=15}

      backgroundColor = "#445577CC";  # цвет фона (CC = ~0.8 прозрачности)&#8203;:contentReference[oaicite:16]{index=16}
      textColor       = "#FFFFFFFF";  # цвет текста (здесь — белый непрозрачный)

      defaultTimeout  = 5000;   # время (мс) показа уведомления, 0 = бесконечно&#8203;:contentReference[oaicite:17]{index=17}
      ignoreTimeout   = false;  # использовать указанный defaultTimeout; если true — игнорирует timeout от уведомления&#8203;:contentReference[oaicite:18]{index=18}

      # Если требуется, можно задать дополнительные параметры:
      # progressColor = "over #5588AAFF";  # цвет индикатора выполнения (оставается по умолчанию)
    };
  };

}
