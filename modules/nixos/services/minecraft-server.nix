{ pkgs, lib, config, inputs, ... }: {
  options = {

    minecraft-server.enable = lib.mkEnableOption "Minecraft server using nix-minecraft";

    minecraft-server.port = lib.mkOption {
      description = "Which port should the minecraft server run on";
      type = lib.types.int;
      default = 25565;
    };
  };

  config = lib.mkIf config.minecraft-server.enable {
    imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

    # Open port
    networking.firewall = {
      allowedTCPPorts = [ config.minecraft-server.port ];
      allowedUDPPorts = [ config.minecraft-server.port ];
    };
  };
}
