{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
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
	modules-left = ["custom/paddl" "custom/ws" "custom/left1" "hyprland/workspaces" "custom/right1" "custom/paddw" "hyprland/window"];
	modules-center = [
	  "custom/paddc"
	    "custom/left2"
	    "custom/cpuinfo"
	    "custom/left3"
	    "memory"
	    "custom/left4"
	    "cpu"
	    "custom/leftin1"
	    "custom/left5"
	    "custom/nix"
	    "custom/right2"
	    "custom/rightin1"
	    "clock#time"
	    "custom/right3"
	    "clock#date"
	    "custom/right4"
	    "custom/wi"
	    "custom/wifi"
	    "custom/right5"
	];
	modules-right = [
	  "custom/media"
	    "custom/left6"
	    "pulseaudio"
	    "custom/left7"
	    "backlight"
	    "custom/left8"
	    "battery"
	    "custom/leftin2"
	    "custom/power"
	];

	"custom/ws" = {
	  format = " ";
	  tooltip = false;
	};
	"hyprland/workspaces" = {
	  all-outputs = false;
	  active-only = false;
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
	  sort-by-number = true;
	};
	"hyprland/window" = {
	  format = "{}";
	  separate-outputs = true;
	  rewrite = {
	    "tesdap@penguin-B =(.*)" = "  $1";
	    "(.*)tesdap@penguin-B =~" = "  tesdap@penguin-B";
	    "(.*) — Mozilla Firefox" = "<span foreground='#f38ba8'>󰈹</span>  $1";
	    "(.*)Mozilla Firefox" = "<span foreground='#f38ba8'>󰈹</span>  Firefox";
	    "(.*) - Visual Studio Code" = "<span foreground='#89b4fa'>󰨞</span>  $1";
	    "(.*)Visual Studio Code" = "<span foreground='#89b4fa'>󰨞</span>  Visual Studio Code";
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
	  format = "󱄅";
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
	border: none;
	font-family: "JetBrainsMono Nerd Font";
	font-weight: bold;
	font-size: 10px;
	min-height: 11px;
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
	border-color: white;
      }

      #workspaces button {
	color: @foreground;
	border-radius: 8px;
	box-shadow: none;
	margin-top: 2px;
	margin-right: 0px;
	margin-bottom: 2px;
	margin-left: 0px;
	padding: 0px;
	padding-right: 2px;
	padding-left: 2px;
	animation: ws_normal 20s ease-in-out 1;
      }

      #workspaces button.active {
	color: @active-fg;
	background: @active-bg;
        text-shadow: 0px 0px 2px rgba(0, 0, 0, 0.6);
        box-shadow: 0px 0px 2px 1px rgba(0, 0, 0, 1);
	margin-right: 2px;
	margin-left: 2px;
	padding-right: 6px;
	padding-left: 6px;
	animation: ws_active 20s ease-in-out 1;
	transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
	color: @hover-fg;
	background: @hover-bg;
        box-shadow: none;
	animation: ws_hover 20s ease-in-out 1;
	transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #custom-ws,
      #workspaces,
      #window,
      #custom-cpuinfo,
      #memory,
      #cpu,
      #clock,
      #custom-wifi,
      #pulseaudio,
      #backlight,
      #battery,
      #custom-power {
      opacity: 1;
	 margin-bottom: 0px;
	 padding-right: 4px;
	 padding-left: 4px;
	 text-shadow: 0px 0px 2px rgba(0, 0, 0, 1);
      }

      #custom-left1,
      #custom-left2,
      #custom-left3,
      #custom-left4,
      #custom-left5,
      #custom-left6,
      #custom-left7,
      #custom-left8 {
        font-size: 11.5pt;
        margin-bottom: -2px;
        text-shadow: -1px 0px 2px rgba(0, 0, 0, 1);
      }

      #custom-right1,
      #custom-right2,
      #custom-right3,
      #custom-right4,
      #custom-right5 {
        font-size: 11.5pt;
        margin-bottom: -2px;
        padding-right: 3px;
        text-shadow: 1px 0px 2px rgba(0, 0, 0, 1);
      }

      @define-color workspaces    #181825;
      @define-color cpuinfo       #181825;
      @define-color memory        #1e1e2e;
      @define-color cpu           #313244;
      @define-color arch          #b4befe;
      @define-color time          #313244;
      @define-color date          #1e1e2e;
      @define-color wifi          #181825;
      @define-color pulseaudio    #181825;
      @define-color backlight     #1e1e2e;
      @define-color battery       #313244;
      @define-color power         #b4befe;

      #custom-paddl {
        font-size: 11.5pt;
        margin-bottom: -2px;
        margin-left: -3px;
        padding-right: 2px;
        background: @background;
      }

      #custom-ws {
        background: @background;
      }

      #custom-left1 {
        color: @workspaces;
        background: @background;
        padding-left: 2px;
      }

      #workspaces {
        padding: 0;
        background: @workspaces;
      }

      #custom-right1 {
        color: @workspaces;
        background: @background;
      }

      #custom-paddc {
        padding-right: 3px;
      }

      #custom-left2 {
        color: @cpuinfo;
        background: @background;
        border-radius: 10px;
        padding-left: 3px;
      }

      #custom-cpuinfo {
        background: @cpuinfo;
        padding-left: 1px;
        padding-right: 0px;
      }

      #custom-left3 {
        color: @memory;
        background: @cpuinfo;
        padding-left: 3px;
      }

      #memory {
        background: @memory;
        padding-left: 1px;
        padding-right: 0px;
      }

      #custom-left4 {
        color: @cpu;
        background: @memory;
        padding-left: 3px;
      }

      #cpu {
        background: @cpu;
      }

      #custom-leftin1 {
        color: @cpu;
        font-size: 11.5pt;
        margin-bottom: -2px;
      }

      #custom-left5 {
        color: @arch;
        background: @background;
        text-shadow: -1px 0px 2px rgba(0, 0, 0, 0.6);
        padding-left: 3px;
      }

      #custom-nix {
        color: black;
        background: @arch;
        font-size: 11pt;
        margin-right: -1px;
        margin-bottom: -2px;
        padding-right: 0px;
        padding-left: 3px;
        text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);
      }

      #custom-right2 {
        color: @arch;
        background: @background;
      }

      #custom-rightin1 {
        color: @time;
        font-size: 11.5pt;
        margin-bottom: -2px;
      }

      #clock.time {
        background: @time;
      }

      #custom-right3 {
        color: @time;
        background: @date;
      }

      #clock.date {
        background: @date;
      }

      #custom-right4 {
        color: @date;
        background: @wifi;
      }

      #custom-wi {  
        background: @wifi;
        text-shadow: 0px 0px 2px rgba(0, 0, 0, 1);
        margin-right: -2px;
        padding-left: 5px;
      }

      #custom-wifi {
        background: @wifi;
        padding-right: 0px;
        padding-left: 0px;
      }

      #custom-right5 {
        color: @wifi;
        background: @background;
      }

      #custom-media {
        background-color: @background;
        padding-right: 8px;
        padding-left: 8px;
      }

      #custom-left6 {
        color: @pulseaudio;
        background: @background;
        padding-left: 3px;
      }

      #pulseaudio {
        background: @pulseaudio;
      }

      #custom-left7 {
        color: @backlight;
        background: @pulseaudio;
        padding-left: 2px;
      }

      #backlight {
        background: @backlight;
      }

      #custom-left8 {
        color: @battery;
        background: @backlight;
        padding-left: 2px;
      }

      #battery {
        background: @battery;
      }

      #custom-leftin2 {
        color: @battery;
        background: @background;
        font-size: 11.5pt;
        margin-bottom: -2px;
      }

      #custom-power {
        color: @background;
        background: @power;
        text-shadow: 0px 0px 2px rgba(0, 0, 0, 0.6);
        box-shadow: 0px 0px 2px 1px rgba(0, 0, 0, 1);
        border-radius: 20px;
        margin-top: 2px;
        margin-right: 4px;
        margin-bottom: 2px;
        padding-right: 6px;
        padding-left: 9px;
      }

      #custom-power:hover {
        color: @hover-fg;
        background: @hover-bg;
        box-shadow: none;
        transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }
    '';
  };
}
