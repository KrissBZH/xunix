#  ／|、
# (˙、．7
#  |、～ヽ
#  じしf_,)ノ

{ pkgs, lib, ... }:
let
  swaylock = pkgs.writeShellScriptBin "swaylock-script" ''
    ${lib.getExe pkgs.swaylock-effects} \
    --image ${./wallpaper-2.png} \
    --clock \
    --indicator \
    --indicator-radius 100 \
    --indicator-thickness 7 \
    --ring-color 00000000 \
    --key-hl-color 00000000 \
    --line-color 00000000 \
    --inside-color 00000000 \
    --separator-color 00000000 \
    --indicator-y-position 300 \
    --grace 0 \
    --fade-in 0.2 \
    --font 'Sarasa Mono CL' \
    --text-color FFFFFF \
    --ring-wrong-color 00000000 \
    --inside-wrong-color 00000000 \
    --line-wrong-color 00000000 \
    --text-wrong-color F1F2F3 \
    --ring-ver-color 00000000 \
    --inside-ver-color 00000000 \
    --line-ver-color 00000000 \
    --text-ver-color 00000000 \
    --ring-clear-color 00000000 \
    --inside-clear-color 00000000 \
    --line-clear-color 00000000 \
    --text-clear-color F1F2F3 \
    --text-caps-lock-color F1F2FB \
    --datestr '%a, %B %e' \
    --timestr '%H:%M' \
  '';

  swayidle-script = pkgs.writeShellScriptBin "swayidle-script" ''
    ${lib.getExe pkgs.swayidle} -w \
    timeout 900 '${swaylock}/bin/swaylock-script' \
    before-sleep '${swaylock}/bin/swaylock-script' \
    lock '${swaylock}/bin/swaylock-script'
  '';
in
{
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    package = pkgs.sway;
    config = {
      keybindings = import ./keybindings.nix { inherit pkgs; };
      bars = [
        {
          mode = "invisible";
        }
      ];
      window = {
        border = 0;
        titlebar = false;
      };
      output = {
        "eDP-1" = {
          mode = "2560x1600@60Hz";
          scale = "1.5";
          bg = "${./wallpaper-2.png} fill";
        };
      };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      floating = {
        border = 0;
        titlebar = false;
      };
      gaps = {
        inner = 1;
        outer = 1;
      };
      fonts = {
        names = [ "Sarasa Gothic SC" ];
        size = 10.0;
      };
      startup = [
        { command = "wl-paste --type text --watch cliphist store"; }
        { command = "mako"; }
        { command = "swayidle-script"; }
      ];
      modifier = "Mod4";
    };
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    systemd.enable = true;
  };
  home.packages = [
    swaylock
    swayidle-script
  ];
}
