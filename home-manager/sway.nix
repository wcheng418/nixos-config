{ config, lib, pkgs, ... }: 

{
  home.packages = with pkgs; [
    # Fonts
    font-awesome
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    swayidle

    swaybg
    
    playerctl

    brightnessctl

    wl-clipboard

    mako # notification daemon

    wlsunset

    # Screen capture
    grim
    slurp

    wlsunset

    adwaita-icon-theme
  ];

  fonts.fontconfig.enable = true;
  
  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans" ];
    serif = [ "Noto Serif" ];
    monospace = [ "Jetbrains Mono" ];
    emoji = [ "Noto Emoji " "Font Awesome" ];
  };

  services = {
    wlsunset = {
      enable = true;
      latitude = 33.019844;
      longitude = -96.698883;
    };
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 500;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
        { event = "lock"; command = "lock"; }
      ];
    };

    mako = {
      enable = true;
      backgroundColor = "#282a36";
      textColor = "#f8f8f2";
      borderColor = "#282a36";
      defaultTimeout = 5000;  # measured in ms

      extraConfig = ''
        [urgency=low]
        border-color=#282a36

        [urgency=normal]
        border-color=#f1fa8c

        [urgency=high]
        border-color=#ff5555
      '';
    };
  };

  programs = {
    swaylock = {
      enable = true;
      settings = {
        image = "${config.xdg.configHome}/home-manager/sway/nixos.png";
        scaling = "fill";
        ignore-empty-password = true;
        indicator-caps-lock = true;
        show-failed-attempts = true;
        ring-color = "#bd93f9";
      };
    };

    alacritty = {
      enable = true;
      settings = {
        import = [
          "${config.xdg.configHome}/home-manager/alacritty/dracula.toml"
        ];
        shell = "${pkgs.fish}/bin/fish";
        window = {
          dynamic_padding = true;
          opacity = 0.95;
        };
        font.size = 9;
        bell.animation = "EaseOut";
        cursor.style.blinking = "On";
        mouse.hide_when_typing = true;
      };
    };

    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Jetbrains Mono";
          terminal = "${pkgs.alacritty}/bin/alacritty";
        };
        colors = {
          background = "282a36dd";
          text = "f8f8f2ff";
          match = "8be9fdff";
          selection-match = "8be9fdff";
          selection = "44475add";
          selection-text = "f8f8f2ff";
          border = "bd93f9ff";
        };
      };
    };

    waybar = {
      enable = true;
      style = builtins.readFile ./waybar/style.css;
      settings = [{
        modules-left = [
          "sway/workspaces"
          "battery"
          "cpu"
          "disk"
          "memory"
          "sway/window"
        ];
        modules-center = [ "clock" "mpris" ];
        modules-right = [
          "network"
          "temperature"
          "wireplumber"
          "backlight"
          "tray"
          "idle_inhibitor"
          "custom/lock"
          "custom/suspend"
        ];
        "sway/window" = {
          format = "{}";
          max-length = 45;
          tooltip = false;
        };
        temperature = {
          format = "{icon} {temperatureC}°C";
          format-icons = {
            default = [ "" "" "" "" ""];
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          format = " {:%b %d %I:%M %p}";
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = {
            default = [ "" "" "" ];
          };
        };
        cpu = {
          format = "{usage}% ";
          states = {
            critical = 90;
          };
        };
        memory = {
          format = "{percentage}% ";
          states = {
            critical = 85;
          };
        };
        disk = {
          interval = 60;
          format = "{percentage_used}% ";
          path = "/";
        };
        battery = {
          states = {
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          tooltip = true;
          format-full = "{icon} Full";
          format-icons = [ "" "" "" "" "" ];
          tooltip-format = " {time}";
        };
        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ifname}: {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "  Disconnected";
          format-alt = " {bandwidthDownBytes}  {bandwidthUpBytes} ";
          tooltip-format = " {ifname}: {ipaddr}/{cidr}";
        };
        wireplumber = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-bluetooth-muted = "  {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
        };
        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
        		default = "▶";
            brave = "";
        		mpv = "";
        	};
          status-icons = {
            playing = "";
            paused = "";
            stopped = "";
          };
          interval = 1;
        };
        "custom/suspend" = {
          format = "";
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
        };
      }];
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt.platformTheme.name = "dracula";

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false; # Does not work (for now), due to bug when opening background image
    config = {
      gaps.inner = 8;
      seat = {
        "*" = {
          "xcursor_theme" = "Adwaita";
        };
      };
      output = {
        "*" = {
          bg = "${config.xdg.configHome}/home-manager/sway/nixos.png fill";
        };
        "Samsung Electric Company LC27T55 HCPNB03531" = {
          mode = "1920x1080@74.973Hz";
        };
      };
      window = {
        border = 2;
        titlebar = false;
      };
      colors = {
        focused = {
          border = "#bd93f9";
          background = "#bd93f9";
          text = "#f8f8f2";
          indicator = "#ff79c6";
          childBorder = "#bd93f9";
        };
        focusedInactive = {
          border = "#282a36";
          background = "#282a36";
          text = "#f8f8f2";
          indicator = "#8be9fd";
          childBorder = "#282a36";
        };
        unfocused = {
          border = "#282a36";
          background = "#282a36";
          text = "#f8f8f2";
          indicator = "#ff5555";
          childBorder = "#282a36";
        };
        urgent = {
          border = "#282a36";
          background = "#282a36";
          text = "#f8f8f2";
          indicator = "#ffb86c";
          childBorder = "#282a36";
        };
      };
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "fuzzel";
      input = {
        "type:touchpad" = {
          accel_profile = "flat";
          dwt = "disabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
    keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+0" = null;
        "${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${config.wayland.windowManager.sway.config.menu}";
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy -t image/png";
        "--locked ${modifier}+p" = "output $laptop toggle";
        "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "--locked Shift+XF86MonBrightnessDown" = "exec brightnessctl set 1%-";
        "--locked Shift+XF86MonBrightnessUp" = "exec brightnessctl set 1%+";
        "--locked XF86KbdBrightnessUp" = "exec brightnessctl --device=asus::kbd_backlight set +1";

        "--locked XF86KbdBrightnessDown" = "exec brightnessctl --device=asus::kbd_backlight set 1-";
        "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2";
        "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2";
        "--locked Shift+XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- -l 1.2";
        "--locked Shift+XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ -l 1.2";
        "--locked XF86AudioPlay" = "exec playerctl play-pause";
        "--locked XF86AudioStop" = "exec playerctl stop";
        "--locked XF86AudioPrev" = "exec playerctl previous";
        "--locked XF86AudioNext" = "exec playerctl next";
      };
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
    };
    extraConfig = ''
      set $laptop "Thermotrex Corporation TL140ADXP02-0 Unknown"

      bindswitch --reload --locked lid:on output $laptop disable
      bindswitch --reload --locked lid:off output $laptop enable
    '';

  };
}
