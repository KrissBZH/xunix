{ username, ... }:
{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib"
      "/var/log"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
    ];
    files = [ "/etc/machine-id" ];
    users.${username} = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".local"
        ".config"
        ".mozilla"
        ".ssh"
        ".gnupg"
      ];
    };
  };
}
