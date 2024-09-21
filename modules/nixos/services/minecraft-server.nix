{ pkgs, lib, config, inputs, ... }: {
  options = {

    minecraft-server.enable = lib.mkEnableOption "Minecraft server using nix-minecraft";

    minecraft-server.port = lib.mkOption {
      description = "Which port should the minecraft server run on";
      type = lib.types.int;
      default = 25565;
    };
  };

  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];

  config = lib.mkIf config.minecraft-server.enable {
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;

      servers = {
        minecraft-server = {
          enable = true;

          serverProperties = {
            server-port = config.minecraft-server.port;
          };
        };
      };
    };
  };
}
