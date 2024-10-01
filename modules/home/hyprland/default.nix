{ pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = [
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
      ];

      monitor = [ ",highrr,auto,1,bitdepth,10" ];
      animations = {
        enabled = true;
        bezier = "myBezier, 0.16, 1, 0.3, 1";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, myBezier, popin 80%"
          "border, 1, 10, myBezier"
          "fade, 1, 7, myBezier"
          "workspaces, 1, 5, default"
        ];
      };

      decoration = {
        rounding = 7;

        dim_inactive = false;
        dim_strength = 0.7;

        blur = {
          enabled = true;
          size = 2;
          passes = 2;
          vibrancy = 0.4;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
          special = true;
        };

        drop_shadow = false;
        shadow_range = 8;
        shadow_render_power = 3;
        shadow_offset = "2 2";
      };
      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.5;
      };
      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 1;
        "col.active_border" = "0x30303040";
        "col.inactive_border" = "0x30303040";
        layout = "master";
      };

      group = {
        groupbar = {
          render_titles = false;
        };
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        repeat_rate = 30;
        repeat_delay = 300;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };
      gestures = {
        workspace_swipe = true;
      };

      layerrule = [
        "blur, notifications"
        "blur, launcher"
        "blur, lockscreen"
        "ignorealpha 0.69, notifications"
        "ignorealpha 0.69, launcher"
        "ignorealpha 0.69, lockscreen"
      ];

      windowrulev2 = [
        "float, class:^(xdg-desktop-portal-gtk)$,title:^(Open Files)$"
        "noblur, class:^(waybar)$"
        "noblur, class:^(firefox)$"
        "noblur, class:^(Chromium-browser)$" # xwayland
        "noblur, class:^(chromium-browser)$" # wayland
        "noblur, title:^(.*(Disc|WebC)ord.*)$"
        "noblur, title:^(Open File)$"
        "noshadow, class:^(firefox)$"
        "noshadow, class:^(Chromium-browser)$" # xwayland
        "noshadow, class:^(chromium-browser)$" # wayland
        "noshadow, title:^(.*(Disc|WebC)ord.*)$"
        "noanim, class:^(wlogout)$"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod SHIFT, C , killactive ,"
        "$mod      , F , fullscreen , 0"
        "$mod      , R , exec , fuzzel -I"
        "$mod      , Space , togglefloating ,"
        "$mod SHIFT, T , togglegroup ,"
        "$mod SHIFT, J , changegroupactive, f"
        "$mod SHIFT, K , changegroupactive, b"
        "$mod      , P , exec , wlogout"
        "$mod SHIFT, Return , exec , foot"

        "$mod SHIFT, S , exec , grim -g \"$(slurp)\" $HOME/Pictures/$(date '+%Y_%m_%d_%H_%M_%S').png"
        "$mod SHIFT, R , exec , wf-recorder -g \"$(slurp)\" --audio --file=$HOME/Videos/$(date '+%Y_%m_%d_%H_%M_%S').mp4"

        "$mod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "$mod      , T , exec , killall wf-recorder"
        "$mod SHIFT, V , exec , cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"

        # Dwindle Keybind
        "$mod , k , movefocus , u"
        "$mod , j , movefocus , d"

        "$mod , left , movewindow , l"
        "$mod , right , movewindow , r"
        "$mod , up , movewindow , u"
        "$mod , down , movewindow , d"
        "$mod SHIFT , h , movewindow , l"
        "$mod SHIFT , l , movewindow , r"
        "$mod SHIFT , k , movewindow , u"
        "$mod SHIFT , j , movewindow , d"

        "$mod , 1 , workspace , 1"
        "$mod , 2 , workspace , 2"
        "$mod , 3 , workspace , 3"
        "$mod , 4 , workspace , 4"
        "$mod , 5 , workspace , 5"
        "$mod , 6 , workspace , 6"
        "$mod , 7 , workspace , 7"
        "$mod , 8 , workspace , 8"
        "$mod , 9 , workspace , 9"
        "$mod , 0 , workspace , 10"

        "$mod SHIFT , 1 , movetoworkspacesilent , 1"
        "$mod SHIFT , 2 , movetoworkspacesilent , 2"
        "$mod SHIFT , 3 , movetoworkspacesilent , 3"
        "$mod SHIFT , 4 , movetoworkspacesilent , 4"
        "$mod SHIFT , 5 , movetoworkspacesilent , 5"
        "$mod SHIFT , 6 , movetoworkspacesilent , 6"
        "$mod SHIFT , 7 , movetoworkspacesilent , 7"
        "$mod SHIFT , 8 , movetoworkspacesilent , 8"
        "$mod SHIFT , 9 , movetoworkspacesilent , 9"
        "$mod SHIFT , 0 , movetoworkspacesilent , 10"

        ", XF86AudioNext , exec , ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev , exec , ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioPlay , exec , ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPause , exec , ${pkgs.playerctl}/bin/playerctl pause"
        ", XF86AudioStop , exec , ${pkgs.playerctl}/bin/playerctl stop"
      ];

      binde = [
        ", XF86AudioRaiseVolume , exec , ${pkgs.swayosd}/bin/swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume , exec , ${pkgs.swayosd}/bin/swayosd-client --output-volume lower"
        ", XF86AudioMute , exec , ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute , exec , ${pkgs.swayosd}/bin/swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessUp , exec , ${pkgs.swayosd}/bin/swayosd-client  --brightness raise"
        ", XF86MonBrightnessDown , exec , ${pkgs.swayosd}/bin/swayosd-client  --brightness lower"
      ];

      bindm = [
        "$mod , mouse:272 , movewindow"
        "$mod , mouse:273 , resizewindow"
      ];

      xwayland.force_zero_scaling = true;
    };
  };
}
