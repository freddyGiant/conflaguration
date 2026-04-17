{
  imports = [ ./hardware-configuration.nix ];

  logind.settings.Login.HandlePowerKey = "ignore";
}
