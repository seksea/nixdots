# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include the nixos modules
    ./../../modules/nixos

    # Use home manager
    inputs.home-manager.nixosModules.default
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  # networking.networkmanager.enable = true;
  networking.hostName = "homelab1"; # Define your hostname.

  # Enables wireless support via wpa_supplicant.
  # $ wpa_passphrase SSID PASSWORD | sudo tee /etc/wpa_supplicant.conf
  # $ sudo systemctl restart wpa_supplicant
  networking.wireless.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure X11 keyboard layout
    xkb = {
      layout = "gb";
      variant = "";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Use KDE
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure console keymap
  console.keyMap = "uk";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    htop
    vim
    wget
  ];

  # Set up home manager
  home-manager = {
    users = {
      ${config.main-user.username} = (import ./home.nix) config;
    };
  };

  # === Custom Modules ===

  # Setup the main user
  main-user = {
    enable = true;
    username = "will";
  };

  # Enable the mullvad VPN
  mullvad.enable = true;

  # OpenVPN server for creating a tunnel into the home network
  openvpn-server = {
    enable = true;
    peerFingerprints = ''
      <peer-fingerprint>
        8A:B6:36:67:B2:37:A1:D7:FB:75:AD:08:93:36:56:16:A2:E1:30:01:20:39:88:B1:49:4E:87:D7:22:E2:A2:D6
      </peer-fingerprint>
    '';    
  };

  # Enable the Plex Media Server
  plex.enable = true;

  # Enable the SSH server
  ssh-server.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
