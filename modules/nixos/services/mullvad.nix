
{ pkgs, lib, config, ... }: {

  options = {

    mullvad.enable = lib.mkEnableOption "Mullvad VPN";
  
  };

  config = lib.mkIf config.mullvad.enable {

    /*services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };*/


    # Get the config from https://mullvad.net/en/account/openvpn-config?platform=linux,
    # and then follow https://mullvad.net/en/help/split-tunneling-mullvad-vpn
    # and then anything you wish to be forwarded via the VPN you must setup a SOCKS5
    # proxy to 10.8.0.1:1080
    services.openvpn.servers = {
      mullvad_gb_all = { config = '' config /etc/openvpn/mullvad_gb_all.conf ''; };
    };
  };
}
