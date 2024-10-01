{ pkgs, ... }:
{
  boot = {
    tmp = {
      # cleanOnBoot = true;
      useTmpfs = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 5;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

}
