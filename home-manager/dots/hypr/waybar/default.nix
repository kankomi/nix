{ pkgs, ... }:
let
  tailscaleScript = pkgs.writeScriptBin "tailscale_updown" (builtins.readFile ./tailscale.sh);
in
{
  home.packages = with pkgs; [
    pavucontrol
    blueman
    tailscaleScript
    nerd-fonts.jetbrains-mono
  ];

  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        background = "none";
        height = 34;
        margin = "5px 5px";
        spacing = 4;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [
          "clock"
          # "hyprland/window"
        ];
        modules-right = [
          # "group/custom1"
          # "group/custom2"
          # "group/custom3"
          "tray"
          "custom/tailscale"
          "custom/weather"
          # "bluetooth"
          "pulseaudio"
          "battery"
          # "network"
        ];
        "group/custom1" = {
          orient = "horizontal";
          modules = [
            "tray"
            "custom/tailscale"
          ];
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
        };
        "group/custom2" = {
          orient = "horizontal";
          modules = [
            "custom/weather"
          ];
        };
        "group/custom3" = {
          orient = "horizontal";
          modules = [
            "pulseaudio"
            "battery"
          ];
          drawer = {
            transition-duration = 300;
            transition-left-to-right = true;
          };
        };
        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            "magic" = "";
            "default" = "";
            "active" = "";
          };

          persistent-workspaces = {
            "*" = 3;
          };
        };

        "custom/weather" = {
          format = "{}";
          exec = "curl -s 'wttr.in/sonthofen?format=%c%t'";
          interval = 300;
          class = "weather";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          # format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            # "headphones" = "";
            # "handsfree" = "";
            # "headset" = "";
            # "phone" = "";
            # "portable" = "";
            # "car" = "";
            "default" = [
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };
          interval = 10;
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "clock" = {
          format = "{:%d.%m.%Y - %H:%M}";
          format-alt = "{:%A, %B %d at %R}";
        };

        "tray" = {
          icon-size = 16;
          spacing = 10;
        };

        "network" = {
          interface = "wlp1s0";
          format = "{ifname}";
          format-wifi = "";
          format-ethernet = "{ipaddr} 󰊗";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 5;
        };

        "bluetooth" = {
          format = " {status}";
          format-connected = "";
          format-connected-battery = " {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "hyprctl dispatch exec [floating] blueman-manager";
        };

        "custom/tailscale" = {
          format = "{icon}";
          format-icons = {
            "connected" = "";
            "disconnected" = "";
          };
          exec = "${tailscaleScript}/bin/tailscale_updown --status";
          on-click = "${tailscaleScript}/bin/tailscale_updown --toggle";
          exec-on-event = true;
          interval = 2;
          return-type = "json";
          tooltip = true;
        };
      };
    };
  };
}
