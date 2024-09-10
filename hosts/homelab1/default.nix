{ pkgs, lib, inputs, ... }:
{
  # Import all modules
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include the nixos modules
    ./../../modules/nixos

    ./boot.nix # bootloader
    ./display.nix # X11 / DE / DM
    ./localisation.nix # timezone / locale
    ./network.nix # hostname / NetworkManager / wireless
    ./nixos.nix # Nix version / enable flakes / unfree
    ./programs.nix # System programs
    ./services.nix # System services
    ./sound.nix # Pipewire / pulse
    ./users.nix # User config / home manager
    
  ];

}
