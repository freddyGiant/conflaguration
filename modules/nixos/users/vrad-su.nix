{
  users.users.vrad = {
    isNormalUser = true;
    # description = "Vincent";
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "audio"
      "video"
      "docker"
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


