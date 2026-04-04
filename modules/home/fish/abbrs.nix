let
  subcommand = command: expansion: { inherit command expansion; }

  # could consider adding something more generalized, but that isn't needed for now
in {
  programs.fish.shellAbbrs = {
    # basic unix abbrs that we might as well always have
    # even if we don't *strictly* know that all these programs are installed
    # (the overhead is so small)

    c   = "cp --verbose --interactive --archive --dereference";
    la  = "ls --almost-all --escape --color --group-directories-first";
    ll  = "ls --almost-all --escape --color --classify --si -og --group-directories-first";
    moo = "mv --interactive";

    # TODO: move elsewhere?
    jk  = "trash -r -i";
    rs  = "rsync --verbose --recursive --relative --archive --copy-links";
    shit = "ssh -t";
    tree = "tree -C";

    # nix abbrs
    "+" = "nix shell nixpkgs#";
    # FIXME: use correct paths
    nrt = ''
      sudo nixos-rebuild test --impure \
        --flake ~/conflaguration#${hostname}
    '';
    nrs = ''
      sudo nixos-rebuild switch --impure \
        --flake ~/conflaguration#${hostname}
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
