{ pkgs, lib, inputs, config, ... }:
{

  imports = [
    # Use home manager
    inputs.home-manager.nixosModules.default
  ];

  # Setup the main user
  main-user = {
    enable = true;
    username = "will";
  };

  # Set up home manager
  home-manager = {
    users = {
      ${config.main-user.username} = (import ./home.nix) config;
    };
  };
}
