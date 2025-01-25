{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    xdg.portal = {
      enable = true;
      configPackages = [config.wayland.windowManager.hyprland.package];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;

      settings = {
        "$mainMod" = "SUPER";
        "$terminal" = "${inputs.wezterm.packages.${pkgs.system}.default}/bin/wezterm";
        "$file_manager" = "$terminal start --new-tab ${pkgs.lf}/bin/lf";
        "$browser" = "${pkgs.firefox}/bin/firefox";
        "$discord" = "${pkgs.vesktop}/bin/vesktop";
        "$screenshot" = "${pkgs.grimblast}/bin/grimblast --freeze --wait 1 copy area";
        "$color_picker" = "${pkgs.hyprpicker}/bin/hyprpicker -a -r";
        "$lock_screen" = "${pkgs.hyprlock}/bin/hyprlock";

        exec-once = [
          "${pkgs.swww}/bin/swww-daemon"
          "ags"

          "hyprctl setcursor Catppuccin Mocha Lavender 32"
        ];

        input = {
          kb_layout = "us, pl";
          kb_options = "caps:escape, fkeys:basic_13-24, grp:alt_space_toggle";
          follow_mouse = 1;
          sensitivity = "-0.6";
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 1;
          "col.active_border" = "rgba(c0c0feaa) rgba(8caaefff) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };

        decoration = {
          rounding = 15;

          blur = {
            enabled = true;
            xray = true;
            special = true;
            new_optimizations = true;
            size = 2;
            passes = 2;
            brightness = 1;
            noise = 1.17e-2;
            contrast = 1;
            popups = true;
            popups_ignorealpha = 0.6;
          };

          shadow = {
            ignore_window = true;
            offset = "0 2";
            render_power = 4;
            color = "rgba(0000002A)";
          };

          dim_inactive = false;
          dim_strength = 0.1;
          dim_special = 0;
        };

        animations = {
          enabled = true;
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "fluent_decel, 0.1, 1, 0, 1"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1"
          ];
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "windowsIn, 1, 3, md3_decel, popin 60%"
            "windowsOut, 1, 3, md3_accel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 3, md3_decel"
            "layersIn, 1, 3, menu_decel, slide"
            "layersOut, 1, 1.6, menu_accel"
            "fadeLayersIn, 1, 2, menu_decel"
            "fadeLayersOut, 1, 4.5, menu_accel"
            "workspaces, 1, 7, menu_decel, slide"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gestures = {
          workspace_swipe = false;
        };

        workspace = [
          "1, monitor:DP-2, persistent:true"
          "2, monitor:HDMI-A-1, persistent:true, on-created-empty:$browser"
          "3, monitor:HDMI-A-1, persistent:true, on-created-empty:$discord"
          "4, monitor:HDMI-A-1, persistent:true"
          "5, monitor:HDMI-A-1, persistent:true"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bind =
          [
            "$mainMod, C, killactive"
            "$mainMod SHIFT, M, exit"

            "$mainMod, S, exec, $screenshot"
            "$mainMod SHIFT, S, exec, $color_picker"
            "$mainMod, L, exec, $lock_screen"
            "$mainMod, E, exec, $file_manager"
            "$mainMod, B, exec, $browser"
            "$mainMod, V, exec, $discord"
            "$mainMod, Q, exec, $terminal"

            "$mainMod, SPACE, exec, ags -t launcher"
            "$mainMod, Y, exec, ags -t overview"
            "$mainMod, M, exec, ags -t powermenu"

            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod SHIFT, left, movewindow, l"
            "$mainMod SHIFT, right, movewindow, r"
            "$mainMod SHIFT, up, movewindow, u"
            "$mainMod SHIFT, down, movewindow, d"

            "$mainMod, F, fullscreen, 1"
            "$mainMod SHIFT, F, fullscreen, 0"

            ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5"
            ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5"
            ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"
          ]
          ++ map (n: "$mainMod SHIFT, ${toString n}, movetoworkspacesilent, ${toString n}") [
            1
            2
            3
            4
            5
          ]
          ++ map (n: "$mainMod SHIFT CTRL, ${toString n}, movetoworkspacesilent, ${toString (n + 5)}") [
            1
            2
            3
            4
            5
          ]
          ++ map (n: "$mainMod, ${toString n}, workspace, ${toString n}") [
            1
            2
            3
            4
            5
          ]
          ++ map (n: "$mainMod CTRL, ${toString n}, workspace, ${toString (n + 5)}") [
            1
            2
            3
            4
            5
          ];
      };
    };
  };
}
