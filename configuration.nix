# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./secure-boot.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Living on the edge.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.getty.autologinUser = "admin";
  services.getty.helpLine = ''
    🌊 This is the OceanRock! Passwords = usernames 🌊
  '';

  nix = {
    settings = {
      trusted-users = [ "root" "admin" ];

      # Does this have performance impact?
      auto-optimise-store = true;
    };

    daemonCPUSchedPolicy = "batch";

    extraOptions = ''
      experimental-features = nix-command flakes

      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5
      log-lines = 25
      warn-dirty = false
      fallback = true
    '';
  };

  # Networking
  networking.hostName = "oceanrock"; # Define your hostname.
  services.openssh.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zile
    nixpkgs-fmt
    tmux
  ];

  system.stateVersion = "25.05";
}

