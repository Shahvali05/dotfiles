{ pkgs, ... }: {
  imports = [
    ./nvim/neovim.nix
  ];
  home.username = "laraeter";
  home.homeDirectory = "/home/laraeter";
  home.stateVersion = "24.11";

  # Пакеты для пользователя
  home.packages = with pkgs; [
    brave
    lazydocker
    mako
    libnotify
    mpv
  ];

  home.file = {
  };

  systemd.services.zapret = {
    description = "Zapret DPI bypass service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/opt/zapret/init.d/sysv/zapret start";
      ExecStop = "/opt/zapret/init.d/sysv/zapret stop";
      ExecReload = "/opt/zapret/init.d/sysv/zapret restart";
      Environment = "PATH=/run/current-system/sw/bin:/nix/store/*-iptables*/bin:/nix/store/*-nftables*/bin:/nix/store/*-ipset*/bin";
    };
  };

  # services.mako = {
  #   enable = true;
  #   anchor = "top-right";
  #   defaultTimeout = 3000;
  #   backgroundColor = "#2e344099";
  #   textColor = "#d8dee9";
  #   borderColor = "#4c566a";
  #   borderSize = 2;
  #   borderRadius = 5;
  #   font = "Sans 10";
  #   width = 300;
  #   height = 100;
  #   padding = "10";
  #   margin = "10";
  #   layer = "overlay";
  #   extraConfig = ''
  #     [urgency=normal]
  #     on-notify=exec mpv ~/.local/share/sounds/notification.wav
  #   '';
  # };

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
