{ pkgs, lib, config, ... }: {

  options = {

    git.enable = lib.mkEnableOption "git";

    git.username = lib.mkOption {
      description = "Which username should git use";
      type = lib.types.str;
    };

    git.email = lib.mkOption {
      description = "Which email should git use";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = config.git.email;
      userEmail = config.git.email;
    };

    # When it asks for a username, give it username, when it asks 
    # for password then give it your GitHub Personal Access Token
    programs.gh.gitCredentialHelper.enable = true;
  };
}
