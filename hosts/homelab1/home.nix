systemConfig: { config, pkgs, ... }: {

  imports = [
    # Include the home manager modules
    ./../../modules/home-manager
  ];

  home.username = systemConfig.main-user.username;
  home.homeDirectory = "/home/${systemConfig.main-user.username}";

  # firefox browser
  firefox.enable = true;

  # git source control
  git.enable = true;
  git.username = "seksea";
  git.email = "s3ksea@gmail.com";

  # neovim with nixvim
  nvim.enable = true;

  # zellij terminal multiplexer
  zellij.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
