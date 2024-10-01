{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    killall
    zip
    unzip
    git
    screen
    wget
    iputils
    usbutils
    utillinux
    binutils
    cage
    coreutils
    whois
    curl
    gvfs
    ffmpeg
    greetd.gtkgreet
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.fish.enable = true;
}
