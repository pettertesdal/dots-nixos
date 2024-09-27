{ config, pkgs, ... }:
let
  inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base06 base08 base0A;
in
  {

  stylix.targets.waybar.enable = false;
  programs.waybar = { enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mode = "dock";
        height = 20;
        exclusive = true;
        passthrough = true;
        gtk-layer-shell = true;
        reload_style_on_change = true;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-center = [
          "custom/cpuinfo"
          "memory"
          "cpu"
          "custom/nix"
          "clock#time"
          "clock#date"
          "custom/wi"
          "custom/wifi"
        ];
        modules-right = [
          "custom/current"
          "custom/media"
          "pulseaudio"
          "backlight"
          "battery"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          all-outputs = false;
          active-only = false;
          format = "{icon}";
          on-click = "activate";
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "5" = " ";
            };
          sort-by-number = true;

        };
        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
          rewrite = {
            "tesdap@penguin-B:(.*)" = "  $1";
            "(.*)tesdap@penguin-B" = "  tesdap@penguin-B";
            "(.*) — Mozilla Firefox" = "<span foreground='#f38ba8'>󰈹</span>  $1";
            "(.*)Mozilla Firefox" = "<span foreground='#f38ba8'>󰈹</span>  Firefox";
            "nvim" = "<span foreground='#89b4fa'>{}</span>";
            "tms" = "<span foreground='#89b4fa'> </span>";
            "(.*)Spotify" = "<span foreground='#a6e3a1'></span>  Spotify";
            "(.*)Spotify Premium" = "<span foreground='#a6e3a1'></span>  Spotify Premium";
            "Discord" = "<span foreground='#89b4fa'></span>  Discord";
            "GNU Image Manipulation Program" = "<span foreground='#a6adc8'></span>  GNU Image Manipulation Program";
            "OBS(.*)" = "<span foreground='#a6adc8'>󰐌</span>  OBS Studio";
            "VLC media player" = "<span foreground='#fab387'>󰕼</span>  VLC Media Player";
            "ONLYOFFICE Desktop Editors" = "<span foreground='#f38ba8'></span>  OnlyOffice Desktop";
            "qView" = "  qView";
            "(.*).jpg" = "  $1.jpg";
            "(.*).png" = "  $1.png";
            "(.*).svg" = "  $1.svg";
            "/" = "  File Manager";
            "" = "<span foreground='#cba6f7'></span>  tesdap 󰅂 penguin-B";
          };
          min-length = 5;
          max-length = 45;
        };
        "custom/cpuinfo" = {
          exec = "~/.config/waybar/scripts/cpuinfo.sh";
          return-type = "json";
          format = "{}";
          tooltip = true;
          interval = 5;
          min-length = 8;
          max-length = 8;
        };
        "memory" = {
          states = {c = 90;};
          format = "󰘚 {percentage}%";
          format-c = "󰀪 {percentage}%";
          tooltip = true;
          tooltip-format =  "{used:0.1f} GB / {total:0.1f} GB";
          interval = 20;
          min-length = 7;
          max-length = 7;
        };
        "cpu" = {
          format = "󰻠 {usage}%";
          tooltip = false;
          interval = 5;
          min-length = 6;
          max-length = 6;
        };
        "custom/nix" = {
          format = "(󱄅 )";
          tooltip = false;
        };
        "clock#time" = {
          format = "󱑂 {:%H:%M}";
          tooltip = true;
          tooltip-format = "{:%I:%M %p}";
          min-length = 8;
          max-length = 8;
        };
        "clock#date" = {
          format = "󱨴 {:%m-%d}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-click-right = "mode";
            format = {
              months = "<span color='#f5e0dc'><b>{}</b></span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b>{}</b></span>";
            };
          };
          actions = {on-click-right = "mode";};
          min-length = 8;
          max-length = 8;
        };
        "custom/wi" = {  #TODO = Signal strength
          format = "󰤥 ";
          tooltip = false;
        };

        "custom/wifi" = {
          exec = "~/.config/waybar/scripts/network-status.sh";
          interval = 30;
          format = "Wi-Fi";   #use {} to display network name
          tooltip = true;
          tooltip-format = "{}";
          on-click = "~/.config/waybar/scripts/network-menu.sh";
          min-length = 7;
          max-length = 7;
        };
        "custom/current" = {
          exec = "~/.dots/home/modules/system/waybar/scripts/current.sh";
          interval = 0;
          signal = 12;
          format = "{}";
        };

        "custom/media" = {
          exec = "/usr/bin/python3 ~/.config/waybar/scripts/mediaplayer.py";
          format = "{}";
          return-type = "json";
          on-click = "playerctl play-pause";
          min-length = 5;
          max-length = 35;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "婢 {volume}%";
          format-icons = {
            headphone = "󰋋";
            default = ["󰖀" "󰕾"];
          };
          on-click = "~/.config/waybar/scripts/volumecontrol.sh -o m";
          on-click-right = "pavucontrol -t 3";
          on-scroll-up = "~/.config/waybar/scripts/volumecontrol.sh -o i";
          on-scroll-down = "~/.config/waybar/scripts/volumecontrol.sh -o d";
          scroll-step = 10;
          min-length = 6;
          max-length = 6;
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          tooltip = true;
          tooltip-format = "Brightness";
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          min-length = 6;
          max-length = 6;
        };

        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "󱘖 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          tooltip-format = "{timeTo}";
          interval = 1;
          min-length = 6;
          max-length = 6;
        };
        "custom/power" = {
          format = " ";
          tooltip = false;
          on-click = "~/.config/waybar/scripts/logoutlaunch.sh 2";
          on-click-right = "~/.config/waybar/scripts/logoutlaunch.sh 1";
          interval  = 86400;
        };
        "custom/paddl" = {
          format = " ";
          tooltip = false;
        };
        "custom/paddw" = {
          format = " ";
          tooltip = false;
        };
        "custom/paddc" = {
          format = "     ";
          tooltip = false;
        };
        "custom/left1" = {
          format = "";
          tooltip = false;
        };
        "custom/left2" = {
          format = "";
          tooltip = false;
        };
        "custom/left3" = {
          format = "";
          tooltip = false;
        };
        "custom/left4" = {
          format = "";
          tooltip = false;
        };
        "custom/left5" = {
          format = "";
          tooltip = false;
        };
        "custom/right1" = {
          format = "";
          tooltip = false;
        };
        "custom/right2" = {
          format = "";
          tooltip = false;
        };
        "custom/right3" = {
          format = "";
          tooltip = false;
        };
        "custom/right4" = {
          format = "";
          tooltip = false;
        };
        "custom/right5" = { format = "";
          tooltip = false;
        };
        "custom/leftin1" = {
          format = "";
          tooltip = false;
        };
        "custom/leftin2" = {
          format = "";
          tooltip = false;
        };

        "custom/rightin1" = {
          format = "";
          tooltip = false;
        };
      };
    };
    style = ''
      * {
      }


      window#waybar {
        background: @background;
      }



      tooltip {
        color: @foreground;
        background: @background;
        border: solid;
        border-width: 1.5px;
        border-radius: 7px;
        border-color: #${base05}
      }

      #workspaces {
        background: #${base00};
        border-bottom: 3px solid #${base05};
      }
      #workspaces button {
        color: #${base01};
      }

      #workspaces button.active {
        color: @active-fg;
        background: @active-bg;
      }
      #window {
      }
      #current {
        background: #${base00};
      }
      '';
  };
}
