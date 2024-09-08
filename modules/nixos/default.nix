
{ pkgs, lib, inputs, ... }:

{
  # Import all modules
  imports = [
    ./main-user.nix

    ./services/plex.nix
    ./services/ssh-server.nix
  ];

}
