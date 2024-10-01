{ username, inputs, ... }:
{
  imports = [ ./nixos ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs;
    };
    users.${username} = import ./home;
  };
}
