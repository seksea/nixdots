
{ pkgs, lib, inputs, ... }:

{
  # Import all modules
  imports = [
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/zellij.nix
  ];
}
