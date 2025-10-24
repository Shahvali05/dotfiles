{ config, pkgs, ... }:

{
  services.dbus.enable = true;
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      local   all   all   trust
      host    all   all   127.0.0.1/32   trust
      host    all   all   ::1/128        trust
    '';
  };

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --time --time-format '%I:%M %p | %a • %h | %F'";
  #       user = "greeter";
  #     };
  #   };
  # };

  # Устанавливаем и включаем SDDM с темой SilentSDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    # Указываем тему (см. ниже — мы добавим её в environment)
    theme = "SilentSDDM";

    settings = {
      General = {
        InputMethod = "qtvirtualkeyboard";
        GreeterEnvironment = "QML2_IMPORT_PATH=/usr/share/sddm/themes/SilentSDDM/components/,QT_IM_MODULE=qtvirtualkeyboard";
      };
    };
  };

  # Подтягиваем тему SilentSDDM из GitHub
  environment.systemPackages = with pkgs; [
    qtbase
    qtsvg
    qtvirtualkeyboard
    qtmultimedia
  ];

  environment.etc."sddm/themes/SilentSDDM".source = pkgs.fetchFromGitHub {
    owner = "uiriansan";
    repo = "SilentSDDM";
    rev = "main";
    # ⚠️ при первой сборке Nix выдаст ошибку с настоящим sha256, вставь его сюда:
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  programs.xwayland.enable = true;

  services.resolved.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  systemd.services.tartarus-startpage = {
    description = "tartarus-startpage";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.python3}/bin/python3 -m http.server 8080";
      WorkingDirectory = "/home/red/nixos/system/user-services/tartarus-startpage/";
      Restart = "always";
      User = "red";
    };
  };

  services.redis.servers.default = {
    enable = true;
    port = 6379;
    bind = "127.0.0.1";
    settings = {
      maxmemory = "256mb";
      maxmemory-policy = "allkeys-lru";
    };
  };
}
