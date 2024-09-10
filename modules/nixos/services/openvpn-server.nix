
{ pkgs, lib, config, ... }: {

  options = {

    openvpn-server.enable = lib.mkEnableOption "OpenVPN Server";
  
    openvpn-server.port = lib.mkOption {
      description = "Which port should the OpenVPN server use";
      type = lib.types.int;
      default = 1194;
    };
    
    openvpn-server.peerFingerprints = lib.mkOption {
      description = "The fingerprints of the client/s. https://github.com/openvpn/openvpn/blob/master/doc%2Fman-sections%2Fexample-fingerprint.rst";
      type = lib.types.str;
      default = ''
        <peer-fingerprint>

        </peer-fingerprint>
      '';
    };

    openvpn-server.keyPath = lib.mkOption {
      description = "The path to the .key file used for OpenVPN auth. https://github.com/openvpn/openvpn/blob/master/doc%2Fman-sections%2Fexample-fingerprint.rst`";
      type = lib.types.str;
      default = "/etc/openvpn/openvpn-server.key";
    };

    openvpn-server.certPath = lib.mkOption {
      description = "The path to the .crt file used for OpenVPN auth. https://github.com/openvpn/openvpn/blob/master/doc%2Fman-sections%2Fexample-fingerprint.rst`";
      type = lib.types.str;
      default = "/etc/openvpn/openvpn-server.crt";
    };
  };

  config = lib.mkIf config.openvpn-server.enable {
    networking.nat = {
      enable = true;
      externalInterface = "wlp0s20f3";
      internalInterfaces  = [ "tun1" ];
    };

    networking.firewall.trustedInterfaces = [ "tun1" ];
    networking.firewall.allowedUDPPorts = [ config.openvpn-server.port ];

    services.openvpn.servers = {
      openvpn-server = {
        config = ''
          # The server certificate we created in step 1
          cert ${config.openvpn-server.certPath}
          key ${config.openvpn-server.keyPath}

          dh none
          dev tun1

          port ${toString config.openvpn-server.port}

          # Listen on IPv6+IPv4 simultaneously
          proto udp6

          # The ip address the server will distribute
          # Use 10.9.0.0 instead of 10.8 as 10.8 is used by mullvad? (without this change, mullvad VPN goes angry)
          server 10.9.0.0 255.255.255.0
          server-ipv6 fd00:6f76:706e::/64

          # A tun-mtu of 1400 avoids problems of too big packets after VPN encapsulation
          tun-mtu 1400

          # The fingerprints of your clients. After adding/removing one here restart the
          # server
          ${config.openvpn-server.peerFingerprints}

          # Notify clients when you restart the server to reconnect quickly
          explicit-exit-notify 1

          # Ping every 60s, restart if no data received for 5 minutes
          keepalive 60 300
        '';
      };
    };
  };
}
