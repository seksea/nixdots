{ pkgs, lib, config, ... }: {

  options = {
    zellij.enable = lib.mkEnableOption "zellij";
  };

  config = lib.mkIf config.zellij.enable {
    programs.zellij = {
      enable = true;

      settings = {

      };
    };
  };
}
