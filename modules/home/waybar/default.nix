{ pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    style = ''
       * {
         font-family: "Sarasa Mono SC, monospace";
         font-size: 15px;
         font-weight: normal;
         border-radius: 0px;
         transition-property: background-color;
         transition-duration: 0.5s;
       }

       @keyframes blink_red {
         to {
           background-color: rgb(51, 31, 37);
         }
       }

       .warning {
         animation-name: blink_red;
         animation-duration: 1s;
         animation-timing-function: linear;
         animation-iteration-count: infinite;
         animation-direction: alternate;
       }

       window#waybar {
         background-color: #1b1b1b;
       }

       window > box {
         margin-left: 5px;
         margin-right: 5px;
         padding: 6px 4px;
         background-color: transparent;
       }

      #custom-launcher {
         padding: 1px;
         margin-left: 4px;
         margin-right: 4px;
         color: rgb(217, 224, 238);
         border-radius: 999px;
       }

       #workspaces {
         padding-left: 5px;
       }

       #workspaces button {
         padding: 1px;
         margin-right: 4px;
         color: rgb(217, 224, 238);
         border-radius: 999px;
       }

       #workspaces button.visible {
         color: #f1f1f1;
         background: #303030;
         font-weight: bold;
       }

       #workspaces button.urgent {
         color: #f3f3f3;
       }

       #workspaces button:hover {
         background-color: #1f2124;
         color: #f3f3f3;
       }

       tooltip {
         background: #1b1b1b;
       }

       tooltip label {
         color: rgb(217, 224, 238);
       }

       #backlight,
       #clock,
       #pulseaudio,
       #network,
       #battery {
         margin-left: 10px;
         padding-left: 10px;
         padding-right: 10px;
         border-radius: 6px;
         background: #303030;
         color: rgb(217, 224, 238);
       }
    '';

    settings = {
      mainBar = {
        "layer" = "top"; # Waybar at top layer
        "position" = "top";
        # "height" = 18;
        "modules-left" = [
          "custom/launcher"
          "hyprland/workspaces"
        ];
        "modules-center" = [ "hyprland/window" ];
        "modules-right" = [
          # "cpu"
          # "memory"
          "network"
          "backlight"
          "pulseaudio"
          "clock"
          "battery"
        ];

        "custom/launcher" = {
          "format" = "󰠖 ";
          "tooltip" = false;
          "on-click" = "fuzzel -I";
          "on-click-right" = "fuzzel -I";
        };

        "hyprland/workspaces" = {
          "all-outputs" = true;
          "format" = "{icon}";
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e-1";
          "on-scroll-down" = "hyprctl dispatch workspace e+1";
          "format-icons" = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            "default" = "󰝥";
          };
        };
        "hyprland/window" = {
          "format" = "{}";
          "rewrite" = {
            "(.*) - fish" = "> [$1]";
          };
          "separate-outputs" = true;
        };
        "cpu" = {
          "format" = "󰻠 {usage}%";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "󰍛 {used:0.1f}G";
        };
        "network" = {
          "format-wifi" = "  {essid}";
          "format-ethernet" = "󰈀 IP Leaked: {ipaddr}/{cidr}";
          "format-linked" = "{ifname} (No IP)";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
          "interval" = 5;
        };
        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 ";
          "format-bluetooth" = "{icon}󰂯 {volume}%";
          "format-bluetooth-muted" = "󰖁󰂯 ";

          # "format-source" = "󰍬 {volume}%";
          # "format-source-muted" = "󰍭";

          "format-icons" = {
            "headphones" = "󰋋";
            "handsfree" = "󱡏";
            "headset" = "󰋋";
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          "on-click" = "${lib.getExe pkgs.ponymix} -N -t sink toggle";
        };
        "clock" = {
          "interval" = 1;
          "format" = "󰅐 {:%I:%M %p}";
          "tooltip-format" = "{:%Y-%m-%d | %H:%M:%S}";
        };
        "battery" = {
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };
        "backlight" = {
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = " {percent}%";
        };
      };
    };
  };
}
