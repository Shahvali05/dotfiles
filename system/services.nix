{ config, pkgs, ... }:

{
  services.dbus.enable = true;
  services.printing.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.polkit-1.fprintAuth = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.power-profiles-daemon.enable = true;

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "mydatabase" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     local   all   all   trust
  #     host    all   all   127.0.0.1/32   trust
  #     host    all   all   ::1/128        trust
  #   '';
  # };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --time --time-format '%I:%M %p | %a • %h | %F'";
        user = "greeter";
      };
    };
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

  # services.redis.servers.default = {
  #   enable = true;
  #   port = 6379;
  #   bind = "127.0.0.1";
  #   settings = {
  #     maxmemory = "256mb";
  #     maxmemory-policy = "allkeys-lru";
  #   };
  # };

  # services.displayManager.ly = {
  #   enable = true;
  # };

  services.xserver.windowManager.qtile.enable = true;

  services.fprintd.enable = true;
}
