{ pkgs, lib, config, ... }: {

  options = {
    main-user.enable = lib.mkEnableOption "main-user";

    main-user.username = lib.mkOption {
      description = "The main-user's username";
      type = lib.types.str;
      default = "main-user";
        };
  };

  config = lib.mkIf config.main-user.enable {
    programs.zsh.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.main-user.username} = {
      isNormalUser = true;
      description = "Main User";

      extraGroups = [ "networkmanager" "wheel" ];

      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = [
        # Generate keys on your client using `ssh-keygen -t rsa`
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0ef+2jXpynRYPYQYx1XyoNGZsbj2oo4TtX8CuRJ6O7046BUgzg/nOW/jbrIzDuhHbdhawjXI+ITYT7TZcuN1TnfyxEkGB3jFMygs8ZmyltnVi5yDRLtk6g/LL/tvIYPPuyy0MC1aMCSCihyXA99z1tojIe1pxjLd7R6rM0cF/dgtf9XW02LidhlGlZ63FHtDa3JQTCIqLB9aTpus73+rBYN3vBOz7HNajKt47x+NR9NinEXeRJkkjjnB+ZniwLssYmQ4syhV4y28LaPNvgiBxoRs/TcFF7Ta8bCbB+ejfk6G99mJB2r5V4VvpHsOLX3OsE9DVouIkT0BZigQ/yDfeBJMEWvQs4jmUmh45aZRQ8Hi/pd6UPcPqYZro27n+HrseQ8u9A7VFHtvsanNGm98+MqpJ3mzz4LJCbDSQgNdo3oUBqmuJQRYsrbFD3lC+OUPxOIhCU5gIz6yFV7B9T8ZO9j+63A6nVkx9sbZ3g3uDHykEEhnG30skIyRDJfpqqUs= u0_a350@localhost"
      ];
    };
  };
}
