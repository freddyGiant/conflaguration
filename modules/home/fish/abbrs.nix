let
  # could consider adding something more generalized, but that isn't needed for now
  subcommand = command: expansion: { inherit command expansion; };
in { conflagurationPath, secrets, ... }: {
  programs.fish.shellAbbrs = {
    # basic unix abbrs that we might as well always have
    # even if we don't *strictly* know that all these programs are installed
    # (the overhead is so small)

    c   = "cp --verbose --interactive --archive --dereference";
    la  = "ls --almost-all --escape --color --group-directories-first";
    ll  = "ls --almost-all --escape --color --classify --si -og --group-directories-first";
    moo = "mv --interactive";
    rs  = "rsync --verbose --recursive --relative --archive --copy-links";

    # nix abbrs

    "+" = "nix shell nixpkgs#";
    # FIXME: use correct paths
    nrt = ''
      sudo nixos-rebuild test \
        --flake ${conflagurationPath} \
        --override-input secrets ${secrets.path}
    '';
    nrs = ''
      sudo nixos-rebuild switch \
        --flake ${conflagurationPath} \
        --override-input secrets ${secrets.path}
    '';

    fl = subcommand "nix" "flake";
    dv = subcommand "nix" "develop --command env SHELL=(which fish) fish";

    # TODO: implement this properly when we actually start using standalone home-manager
    # hs  = ''
    #   home-manager switch --impure \
    #     --flake ${final.home.homeDirectory}/hm#${final.home.username}@${hostname}
    # '';
  };

  programs.fish.preferAbbrs = true;
}
