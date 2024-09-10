{ pkgs, lib, inputs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    htop
    vim
    wget
  ];
}
