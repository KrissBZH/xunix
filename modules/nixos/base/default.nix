{
  config,
  lib,
  pkgs,
  inputs,
  kblayout,
  ...
}:
{
  imports = [ ./packages.nix ];

  # users.mutableUsers = lib.mkDefault false;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console.keyMap = "fr";
  environment.variables = {
    "XKB_DEFAULT_LAYOUT" = "fr";
  };
  #  programs.command-not-found.dbPath =
  #    inputs.programsdb.packages.${pkgs.stdenv.hostPlatform.system}.programs-sqlite;

  nixpkgs.config.allowUnfree = true;

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    channel.enable = false;
    settings = {
      sandbox = true;

      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "flakes"
        "no-url-literals"
        "nix-command"
        "parse-toml-timestamps"
        "read-only-local-store"
        "recursive-nix"
      ];

      commit-lockfile-summary = "chore: Update flake.lock";
      accept-flake-config = true;
      auto-optimise-store = true;
      keep-derivations = true;
      keep-outputs = true;

      warn-dirty = false;

      trusted-users = [
        "root"
        "@wheel"
      ];
      allowed-users = [ "@wheel" ];

      substituters = [
        "https://nix-community.cachix.org?priority=43"
        "https://cache.garnix.io?priority=60"
      ];

      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    registry = {
      system.flake = inputs.nixpkgs;
      default.flake = inputs.nixpkgs;
      nixpkgs.flake = inputs.nixpkgs;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
    optimise.automatic = true;
  };

  services = {
    # Service that makes Out of Memory Killer more effective
    earlyoom.enable = true;
    timesyncd.enable = true;
    # Enable periodic SSD TRIM of mounted partitions in background
    fstrim.enable = true;
    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend-then-hibernate";
    };
  };

  documentation = {
    enable = false;
    doc.enable = false;
    nixos.enable = false;
    man.enable = true;
    dev.enable = false;
  };

}
