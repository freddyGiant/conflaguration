{
  users.users.vrad = {
    isNormalUser = true;
    # description = "Vincent";
    extraGroups = [
      "wheel"
      "input"
      "audio"
      "video"
      # "docker"
    ];
  };

  sudo.extraRules = [{
    users = [ "vrad" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
}
