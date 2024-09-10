{ pkgs, lib, inputs, ... }:
{

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;


    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Use KDE
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

}
