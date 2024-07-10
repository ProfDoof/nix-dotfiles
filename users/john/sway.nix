{ config, pkgs, ... }:
{
  home.packages = [
    # Dev
    dotnet-sdk
    fsautocomplete
  ];
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      fonts = {
        size = 14.0;
      };
      gaps = {
        inner = 5;
        outer = 5;
      };
    };
    extraConfig = ''
      # Brightness Controls
      bindsym XF86MonBrightnessDown exec light -U 10
      bindsym XF86MonBrightnessUp exec light -A 10

      # Audio Controls
      bindsym XF86AudioRaiseVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_SINK@ +1.0%'
      bindsym XF86AudioLowerVolume exec 'wpctl set-volume -l 1.0 @DEFAULT_SINK@ -1.0%'
      bindsym XF86AudioMute exec 'wpctl set-mute @DEFAULT_SINK@ toggle'
    '';
  };
}
