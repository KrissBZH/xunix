{
  username,
  lib,
  config,
  pkgs,
  ...
}:
{

  users.users.${username} = {
    shell = pkgs.fish;
    uid = 1000;
    password = "1";
    # generated hashedPassword by command mkPasswd
    # hashedPassword = "$y$j9T$nNg2yQ3eADfg4R8YDVd1S0$rshQwNOVdsHGSp6h1ZnhbkL96A5yJX9.G3zqOU7esh3";
    isNormalUser = true;
    extraGroups =
      [
        "seat"
        "wheel"
        "video"
      ]
      ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd"
      ++ lib.optional config.virtualisation.docker.enable "docker"
      ++ lib.optional config.networking.networkmanager.enable "networkmanager";
  };
}
