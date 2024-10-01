{ config, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "screen-256color";
        font = "Sarasa Mono SC:size=9";
        dpi-aware = "yes";
        initial-window-size-chars = "82x23";
        initial-window-mode = "windowed";
        pad = "10x10";
        resize-delay-ms = 100;
      };
      colors = {
        alpha = "0.88";
        foreground = "${config.color.base05}"; # Text
        background = "${config.color.background}"; # colors.base

        regular0 = "${config.color.base03}"; # Surface 1
        regular1 = "${config.color.base08}"; # red
        regular2 = "${config.color.base0B}"; # green
        regular3 = "${config.color.base0A}"; # yellow
        regular4 = "${config.color.base0D}"; # blue
        regular5 = "${config.color.base0F}"; # pink
        regular6 = "${config.color.base0C}"; # teal
        regular7 = "${config.color.base06}"; # Subtext 0
        bright0 = "${config.color.base04}"; # Surface 2
        bright1 = "${config.color.base08}"; # red
        bright2 = "${config.color.base0B}"; # green
        bright3 = "${config.color.base0A}"; # yellow
        bright4 = "${config.color.base0D}"; # blue
        bright5 = "${config.color.base0F}"; # pink
        bright6 = "${config.color.base0C}"; # teal
        bright7 = "${config.color.base07}"; # Subtext 0
      };
      mouse = {
        hide-when-typing = "yes";
        alternate-scroll-mode = "yes";
      };
    };
  };
}
