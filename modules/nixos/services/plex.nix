{ pkgs, lib, config, ... }: {

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
      # Plex Media Server (web access at port 32400)
      plex = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };

      # TV Indexer (port 7878)
      sonarr = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };

      # Movie Indexer (port 8989)
      radarr = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
      };

      # Subtitles Indexer (port 6767)
      bazarr = {
        enable = true;
        group = "multimedia";
        openFirewall = true;
        listenPort = 6767;
      };

      # Torrent Indexer (port 9696)
      prowlarr = {
        enable = true;
        openFirewall = true;
      };

      /*nzbget = {
        enable = true;
        group = "multimedia";
      };*/

      # Torrent web client (port 8112)
      deluge = {
        enable = true;
        group = "multimedia";
        web.enable = true;
        web.openFirewall = true;
        web.port = 8112;
        dataDir = "/media/torrent";
        declarative = true;
        config = {
          enabled_plugins = [ "Label" ];
          stop_seed_at_ratio = true;
          dont_count_slow_torrents = true;
          max_active_seeding = 50;
          max_active_downloading = 50;
          max_active_limit = 200;
          proxy = {
            type = 2;
            hostname = "10.8.0.1";
            username = "";
            password = "";
            port = 1080;
            proxy_hostnames = true;
            proxy_peer_connections = true;
            proxy_tracker_connections = true;
            force_proxy = true;
            anonymous_mode = false;
          };
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
