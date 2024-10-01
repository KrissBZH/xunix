{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam;
  };

  hardware.steam-hardware.enable = true;
}
