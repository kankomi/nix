{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    waybar = {
      enable = true;
      style = builtins.readFile ./waybar/styles.css;
      settings = {
        mainBar = {
          height = 20;
          spacing = 4;
          modules-left = ["custom/appmenu" "group/quicklinks" "hyprland/window"];
          modules-center = ["hyprland/workspaces"];
          modules-right = [
            "mpd"
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "keyboard-state"
            "battery"
            "clock"
            "tray"
            "custom/exit"
          ];

          "hyprland/workspaces" = {
            on-click = "activate";
            active-only = false;
            all-outputs = true;
            format = "{}";
            format-icons = {
              urgent = "";
              active = "";
              default = "";
            };
            persistent-workspaces = {
              "*" = 3;
            };
          };

          "hyprland/window" = {
            rewrite = {
              "(.*) - Brave" = "$1";
              "(.*) - Chromium" = "$1";
              "(.*) - Brave Search" = "$1";
              "(.*) - Outlook" = "$1";
              "(.*) Microsoft Teams" = "$1";
            };
            separate-outputs = true;
          };

          "custom/appmenu" = {
            format = "Apps";
            tooltip-format = "Left: Open the application launcher\nRight: Show all keybindings";
            on-click = "rofi -show drun -replace";
            # "on-click-right"= "~/.config/ml4w/scripts/keybindings.sh",
            tooltip = false;
          };

          bluetooth = {
            format-disabled = "";
            format-off = "";
            interval = 30;
            on-click = "blueman-manager";
            format-no-controller = "";
          };

          clock = {
            timezone = "Europe/Berlin";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          pulseaudio = {
            "format" = "{icon}  {volume}%";
            "format-bluetooth" = "{volume}% {icon} {format_source}";
            "format-bluetooth-muted" = " {icon} {format_source}";
            "format-muted" = " {format_source}";
            "format-source" = "{volume}% ";
            "format-source-muted" = "";
            "format-icons" = {
              "headphone" = "";
              "hands-free" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" " " " "];
            };
            "on-click" = "pavucontrol";
          };

          battery = {
            states = {
              # // "good"= 95,
              warning = 30;
              critical = 15;
            };
            "format" = "{icon}   {capacity}%";
            "format-charging" = "  {capacity}%";
            "format-plugged" = "  {capacity}%";
            "format-alt" = "{icon}  {time}";
            # // "format-good"= "", // An empty format will hide the module
            # // "format-full"= "",
            "format-icons" = [" " " " " " " " " "];
          };

          network = {
            "format" = "{ifname}";
            "format-wifi" = "   {signalStrength}%";
            "format-ethernet" = "  {ipaddr}";
            "format-disconnected" = "Not connected";
            "tooltip-format" = " {ifname} via {gwaddri}";
            "tooltip-format-wifi" = "   {essid} ({signalStrength}%)";
            "tooltip-format-ethernet" = "  {ifname} ({ipaddr}/{cidr})";
            "tooltip-format-disconnected" = "Disconnected";
            "max-length" = 50;
            "on-click" = "alacritty -e nmtui";
          };

          "group/hardware" = {
            "orientation" = "inherit";
            "drawer" = {
              "transition-duration" = 300;
              "children-class" = "not-memory";
              "transition-left-to-right" = false;
            };
            "modules" = [
              "custom/system"
              "disk"
              "cpu"
              "memory"
              "hyprland/language"
            ];
          };

          disk = {
            "interval" = 30;
            "format" = "D {percentage_used}% ";
            "path" = "/";
            "on-click" = "alacritty -e htop";
          };

          "custom/system" = {
            "format" = "";
            "tooltip" = false;
          };

          "cpu" = {
            "format" = "/ C {usage}% ";
            "on-click" = "alacritty -e htop";
          };

          "memory" = {
            "format" = "/ M {}% ";
            "on-click" = "alacritty -e htop";
          };

          "custom/exit" = {
            "format" = "";
            "tooltip-format" = "Powermenu";
            "on-click" = "wlogout -b 4";
            "tooltip" = false;
          };

          "keyboard-state" = {
            "numlock" = true;
            "capslock" = true;
            "format" = "{name} {icon}";
            "format-icons" = {
              "locked" = "";
              "unlocked" = "";
            };
          };
        };
      };
    };
  };
}
