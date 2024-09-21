{ config, pkgs, lib, inputs, ... }:
{
  minecraft-server = {
    enable = true;
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

}
