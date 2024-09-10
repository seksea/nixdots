{ pkgs, lib, inputs, ... }:
{
  # Networking
  # networking.networkmanager.enable = true;
  networking.hostName = "homelab1"; # Define your hostname.

  # Enables wireless support via wpa_supplicant.
  # $ wpa_passphrase SSID PASSWORD | sudo tee /etc/wpa_supplicant.conf
  # $ sudo systemctl restart wpa_supplicant
  networking.wireless.enable = true;
}
