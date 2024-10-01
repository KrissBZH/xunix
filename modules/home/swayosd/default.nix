{ config, pkgs, ... }:
{
  # https://github.com/ErikReider/SwayOSD/blob/11271760052c4a4a4057f2d287944d74e8fbdb58/data/style/style.scss
  xdg.configFile."swayosd/style.css".text = ''
    window#osd {
      padding: 12px 20px;
      border-radius: 999px;
      border: none;
      background: #303030;
    }

    #container {
      margin: 16px;
    }

    progressbar:disabled,
    image:disabled {
      opacity: 0.5;
    }

    progressbar {
      min-height: 6px;
      border-radius: 10%;
      background: transparent;
      border: none;
    }

    trough {
      min-height: inherit;
      border-radius: inherit;
      border: none;
    }

    progress {
      min-height: inherit;
      border-radius: inherit;
      border: none;
    }
  '';
  services.swayosd = {
    enable = true;
    topMargin = 0.5;
    display = "eDP-1";
    stylePath = "${config.xdg.configHome}/swayosd/style.css";
  };

  home.packages = [ pkgs.swayosd ];
}
