{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    vlc
    cliphist
    imv
    hyprpicker
    fastfetch
    grim
    brightnessctl
    wf-recorder
    ponymix
    slurp
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    VISUAL = "nvim";
    TERM = "xterm-256color";
    BROWSER = "firefox";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
