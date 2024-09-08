{ pkgs, lib, config, inputs, ... }: {

  options = {
    nvim.enable = lib.mkEnableOption "custom neovim with spacevim";
  };


  config = lib.mkIf config.nvim.enable {
    # todo: make a real nvim with custom plugins
    home.packages = with pkgs; [
      spacevim
    ];
  };
}
