{
  description = "Sekc's Nix Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {
    # Custom shell environment "nix develop github:seksea/nix-dots"
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        pkgs.neovim
      ];
    };

    # NixOS homelab 1 machine configuration (LG Gram)
    # sudo nixos-rebuild switch --flake .#homelab1
    nixosConfigurations.homelab1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/homelab1
      ];
    };

    homeManagerModules.default = ./modules/home-manager/default.nix;
  };
}
