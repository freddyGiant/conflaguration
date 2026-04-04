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
      strCon = lib.concatStringSep;
      opt = lib.optional;

      # keychainBinary = "${keychain.package}/bin/keychain";
      # withOptionIf = condition: option:
      #   lib.optional condition " \\\n${option}";
  
      keychainCommand = strCon " \\\n" (lib.concatLists [
        [ "${kc.package}/bin/keychain" ]
        [ "--eval" ]
        (opt (kc.extraFlags   != [ ]) (strCon " " kc.extraFlags))
        (opt (kc.inheritType  != null) "--inherit ${keychain.inheritType}")
        (opt (keychain.agents != [ ])  "--agents ${strCon "," kc.agents}")
        (opt (keychain.keys   != [ ]) (strCon " " keychain.keys}))
      ]);
    in "${keychainBinary}${withOptionIf true 

      ''
      ${keychainBinary} \
        --eval${
          lib.optionalString
            (keychain.extraFlags != [ ])
            " \\\n${lib.concatStringsSep " " keychain.extraFlags}"
        }${
          lib.optionalString
            (keychain.inheritType != null)
            " \\\n--inherit ${keychain.inheritType}"
        }${
          lib.optionalString
            (keychain.agents != [ ])
            " \\\n--agents ${lib.concatStringSep "," keychain.agents}"
        }${
          lib.optionalString
            (keychain.keys != [ ])
            " \\\n${lib.concatStringsSep " " keychain.keys}"
        } \
      # | tee /home/vrad/debug \
      | source
    '');
  };
}
