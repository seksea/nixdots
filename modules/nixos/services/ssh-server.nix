{ pkgs, lib, config, ... }: {

  # Register SSH keys in your nixosModules/main-user.nix like so:
  #
  # openssh.authorizedKeys.keys = [
  #   # Generate keys on your client using `ssh-keygen -t rsa`
  #   "ssh-rsa AA..."
  # ];

  options = {

    minecraft-server.enable = lib.mkEnableOption "SSH server";

    ssh-server.port = lib.mkOption {
      description = "Which port should the SSH server use";
      type = lib.types.int;
      default = 22;
    };
  };

  config = lib.mkIf config.ssh-server.enable {
    services.openssh = {
      enable = true;
      ports = [ config.ssh-server.port ];
    };

    # Open port 22 (SSH port)
    networking.firewall = {
      allowedTCPPorts = [ config.ssh-server.port ];
      allowedUDPPorts = [ config.ssh-server.port  ];
    };
  };
}
