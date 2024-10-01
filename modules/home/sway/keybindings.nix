{ pkgs, ... }:
let
  mod = "Mod4";
in
{
  # Kill focused window
  "${mod}+Shift+c" = "kill";

  "${mod}+j" = "focus down";
  "${mod}+k" = "focus up";

  # Move the focused window with the same, but add Shift
  "${mod}+Shift+h" = "move left";
  "${mod}+Shift+j" = "move down";
  "${mod}+Shift+k" = "move up";
  "${mod}+Shift+l" = "move right";

  ### Workspaces
  # Switch to workspace
  "${mod}+1" = "workspace 1";
  "${mod}+2" = "workspace 2";
  "${mod}+3" = "workspace 3";
  "${mod}+4" = "workspace 4";
  "${mod}+5" = "workspace 5";
  "${mod}+6" = "workspace 6";
  "${mod}+7" = "workspace 7";
  "${mod}+8" = "workspace 8";
  "${mod}+9" = "workspace 9";

  # Move focused container to workspace
  "${mod}+Shift+1" = "move container to workspace 1";
  "${mod}+Shift+2" = "move container to workspace 2";
  "${mod}+Shift+3" = "move container to workspace 3";
  "${mod}+Shift+4" = "move container to workspace 4";
  "${mod}+Shift+5" = "move container to workspace 5";
  "${mod}+Shift+6" = "move container to workspace 6";
  "${mod}+Shift+7" = "move container to workspace 7";
  "${mod}+Shift+8" = "move container to workspace 8";
  "${mod}+Shift+9" = "move container to workspace 9";

  ### Resizing containers
  "${mod}+Left" = "resize shrink width 10px";
  "${mod}+Right" = "resize grow width 10px";
  "${mod}+Down" = "resize shrink height 10px";
  "${mod}+Up" = "resize grow height 10px";

  ### Scratchpad
  # Move the currently focused window to the scratchpad
  "${mod}+Shift+q" = "move scratchpad";

  # Show the next scratchpad window or hide the focused scratchpad window.
  # If there are multiple scratchpad windows, this command cycles through them.
  "${mod}+q" = "scratchpad show";

  # Fullscreen
  "${mod}+f" = "fullscreen";

  ### Layout stuff
  "${mod}+c" = "splith";
  "${mod}+v" = "splitv";

  # Switch the current container between different layout styles
  "${mod}+s" = "layout stacking";
  "${mod}+e" = "layout toggle split";
  "${mod}+t" = "layout tabbed";

  # Toggle the current focus between tiling and floating mode
  "${mod}+Space" = "floating toggle";

  # misc

  "${mod}+Shift+Return" = "exec foot";
  "${mod}+r" = "exec fuzzel -I";
  "${mod}+g" = "exec firefox";
  "${mod}+Shift+v" = "exec  cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";
  "${mod}+l" = "exec swaylock-script";

  "${mod}+Shift+s" = "exec grim -g \"$(slurp)\" ~/Pictures/$(date '+%Y_%m_%d_%H_%M_%S').png";
  "${mod}+Shift+r" = "exec wf-recorder -g \"$(slurp)\" --audio --file=$HOME/Videos/$(date '+%Y_%m_%d_%H_%M_%S').mp4";
  "${mod}+Shift+t" = "exec killall wf-recorder";

  XF86AudioRaiseVolume = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume raise";
  XF86AudioLowerVolume = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume lower";
  XF86AudioMute = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle";
  XF86AudioMicMute = "exec ${pkgs.swayosd}/bin/swayosd-client --input-volume mute-toggle";
  XF86MonBrightnessUp = "exec ${pkgs.swayosd}/bin/swayosd-client  --brightness raise";
  XF86MonBrightnessDown = "exec ${pkgs.swayosd}/bin/swayosd-client  --brightness lower";
}
