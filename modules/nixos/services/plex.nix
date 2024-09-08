{ pkgs, lib, config, ... }: {

  # Register SSH keys in your nixosModules/main-user.nix like so:
  #
  # openssh.authorizedKeys.keys = [
  #   # Generate keys on your client using `ssh-keygen -t rsa`
  #   "ssh-rsa AA..."
  # ];

  options = {

    plex.enable = lib.mkEnableOption "Plex Media Server";

  };

  config = lib.mkIf config.plex.enable {
    users.groups.multimedia = { };
    users.users."${config.main-user.username}".extraGroups = [ "multimedia" ];
    
    systemd.tmpfiles.rules = [
      "d /media 0770 - multimedia - -"
      "d /media/movies 0770 - multimedia - -"
      "d /media/torrent 0770 - multimedia - -"
      "d /media/tv 0770 - multimedia - -"
    ];

    services = {
      plex = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };

      sonarr = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };
      
      radarr = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };

      bazarr = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };
      
      prowlarr = {
        enable = true;
        openFirewall = true;
      };

      nzbget = {
        enable = true;
        group = "multimedia";
      };

      deluge = {
        enable = true;
        group = "multimedia";
        web.enable = true;
        web.openFirewall = true;
        dataDir = "/media/torrent";
        declarative = true;
        config = {
          enabled_plugins = [ "Label" ];
        };
        authFile = pkgs.writeTextFile {
          name = "deluge-auth";
          text = ''
            localclient::10
          '';
        };
      };
    };
  };
}
