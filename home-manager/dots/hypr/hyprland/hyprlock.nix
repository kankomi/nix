{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''

      $accent = $mauve
      $accentAlpha = $mauveAlpha
      $font = JetBrainsMono Nerd Font
      $text2 = $textAlpha
      $accent2 = $mauveAlpha

      # INPUT FIELD
      input-field {
        monitor =
          size = 300, 60
          outline_thickness = 4
          dots_size = 0.2
          dots_spacing = 0.2
          dots_center = true
          outer_color = $accent
          inner_color = $surface0
          font_color = $text
          fade_on_empty = false
          placeholder_text = <span foreground="##$text2"><i>󰌾 Logged in as </i><span foreground="##$accent2">$USER</span></span>
          hide_input = false
          check_color = $accent
          fail_color = $red
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
          capslock_color = $yellow
          position = 0, -35
          halign = center
          valign = center
      }
    '';

    settings = {
      source = "${./mocha.conf}";
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          path = "${../../../../assets/wallpapers/beach.jpg}";
          blur_passes = 2;
          color = "$base";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:30000] echo \"\$(date +\"%R\")\"";
          color = "$text";
          font_size = 90;
          font_family = "JetBrainsMono Nerd Font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:43200000] echo \"\$(date +\"%A, %d %B %Y\")\"";
          color = "$text";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];

      image = [
        {
          monitor = "";
          path = "~/.face";
          size = 100;
          border_color = "$accent";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }
      ];

      # input-field = [
      #   {
      #     monitor = "";
      #     size = "300, 60";
      #     outline_thickness = 4;
      #     dots_size = 0.2;
      #     dots_spacing = 0.2;
      #     dots_center = true;
      #     outer_color = "$accent";
      #     inner_color = "$surface0";
      #     font_color = "$text";
      #     fade_on_empty = false;
      #     placeholder_text = "<span foreground=\"#$text2\"><i>󰌾 Logged in as </i><span foreground=\"#$accent2\"><b>$USER</b></span></span>";
      #     hide_input = false;
      #     check_color = "$accent";
      #     fail_color = "$red";
      #     fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
      #     capslock_color = "$yellow";
      #     position = "0, -35";
      #     halign = "center";
      #     valign = "center";
      #   }
      # ];
    };
  };
}
