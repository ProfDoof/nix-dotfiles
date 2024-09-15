{ pkgs, ... }:
{
  home.packages = [

  ];

  programs.waybar.enable = true;

  wayland.windowManager.sway =
    let
      sway-config = pkgs.writeScript "sway-config/check-lid" ''
        #!/bin/sh

        LAPTOP_OUTPUT="eDP-1"
        LID_STATE_FILE="/proc/acpi/button/lid/LID0/state"

        read -r LS < "$LID_STATE_FILE"

        case "$LS" in
        *open)    swaymsg output "$LAPTOP_OUTPUT" enable ;;
        *closed) swaymsg output "$LAPTOP_OUTPUT" disable ;;
        *)       echo "Could not retrieve lid state" >&2 ; exit 1 ;;
        esac
      '';
    in
    {
      enable = true;
      package = null;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        fonts = {
          size = 14.0;
        };
        gaps = {
          inner = 5;
          outer = 5;
        };
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
          }
        ];
      };
      extraOptions = [ "--unsupported-gpu" ];
      extraConfig = ''
        # Brightness Controls bindsym XF86MonBrightnessDown exec light -U 10 bindsym XF86MonBrightnessUp exec light -A 10

               # Audio Controls
               bindsym XF86AudioRaiseVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_SINK@ 1.0%+'
               bindsym XF86AudioLowerVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_SINK@ 1.0%-'
               bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_SINK@ toggle'

               # Monitor configuration
               set $laptop eDP-1
               set $left HDMI-A-3
               set $right DP-3

               output $laptop pos 0 0 res 1920x1080
               output $left pos 1920 0 res 1920x1080
               output $right pos 3840 0 res 1920x1080
               focus output $left 

               bindswitch --reload --locked lid:on output $laptop disable
               bindswitch --reload --locked lid:off output $laptop enable
               exec_always ${sway-config}
      '';
    };
}
