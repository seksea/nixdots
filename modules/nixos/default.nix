
{ pkgs, lib, inputs, ... }:

{
  # Import all modules
  imports = [
    ./main-user.nix

    ./services/mullvad.nix
    ./services/openvpn-server.nix
    ./services/plex.nix
    ./services/ssh-server.nix
  ];

}
