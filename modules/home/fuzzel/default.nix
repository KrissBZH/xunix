{ config, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Sarasa Mono SC";
        terminal = "foot";
        prompt = "->";
      };

      border = {
        width = 0;
        radius = 6;
      };

      dmenu = {
        mode = "text";
      };
      colors = {
        background = "${config.color.base00}f2";
        text = "${config.color.base05}ff";
        match = "${config.color.base0A}ff";
        selection = "${config.color.base03}ff";
        selection-text = "${config.color.base05}ff";
        selection-match = "${config.color.base0A}ff";
        border = "${config.color.base0D}ff";
      };
    };
  };
}
