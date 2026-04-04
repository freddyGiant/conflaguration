{ config, lib, ... }: {
  options = {
    my.ssh.enableFishIntegration =
      lib.hm.shell.mkFishIntegrationOption { inherit config; };
  };

  config = {
    programs.ssh.enable = true;

    programs.keychain.enable = true;
    programs.keychain  = {
      extraFlags = [];
      keys = [
        "--clear"
        "--systemd"
      ];
    };
    # we globally enabled fish integrations
    # but the keychain module has some weird defaults
    programs.keychain.enableFishIntegration = false;

    fish.loginShellInit = lib.mkIf config.my.ssh.enableFishIntegration (let
      kc = config.programs.keychain;
      opt = lib.optional;
      strCon = lib.concatStringSep;

      # NOTE: this is... fine
      keychainCommand = strCon " \\\n" (lib.concatLists [
        [ "${kc.package}/bin/keychain" ]
        [ "--eval" ]
        (opt (kc.extraFlags   != [ ]) (strCon " " kc.extraFlags))
        (opt (kc.inheritType  != null) "--inherit ${keychain.inheritType}")
        (opt (keychain.agents != [ ])  "--agents ${strCon "," kc.agents}")
        (opt (keychain.keys   != [ ]) (strCon " " keychain.keys}))
      ]);
    in ''
      ${keychainCommand} \
      # | tee /home/vrad/debug \
      | source
    '');
  };
}
