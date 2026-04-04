{ config, lib, secrets, ... }: {
  options = {
    my.ssh.enableFishIntegration =
      lib.hm.shell.mkFishIntegrationOption { inherit config; };
  };

  config = {
    programs.ssh.enable = true;
    # stupid
    programs.ssh.enableDefaultConfig = false;
    programs.ssh.matchBlocks = lib.mkMerge [
      {
        "*" = {
          forwardAgent = false;
          hashKnownHosts = true;
          controlMaster = "auto";
          controlPath = "${final.home.homeDirectory}/.ssh/control/%r_%h_%p";
          # extraOptions.RequestTTY = "yes";
        };
      }

      secrets.hosts
    ];

    services.ssh-agent.enable = true;

    programs.keychain.enable = true;
    programs.keychain = {
      extraFlags = [];
      keys = [
        "--clear"
        "--systemd"
      ];
    };
    # we globally enabled fish integrations
    # but the keychain module has some weird defaults
    programs.keychain.enableFishIntegration = false;

    # TODO: better ssh abbrs
    programs.fish.shellAbbrs.shit = "ssh -t";
    programs.fish.loginShellInit = lib.mkIf config.my.ssh.enableFishIntegration (let
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
