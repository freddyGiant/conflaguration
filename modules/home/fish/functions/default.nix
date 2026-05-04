let
  # Configures fish functions from files in this directory
  #
  # Takes an attrset with `name = otherFunctionAttrs` pairs, with
  #   name: string, name of function and corresponding sibling file (except `.fish` extension)
  #   otherFunctionAttrs: attrs, for `programs.fish.functions.<name>`
  #     Aside from `programs.fish.functions.<name>.body`, `functions` submodule
  #     attrs correspond to long names of fish `function` command options.
  #
  #     See `man function` or
  #     [fishshell.com/docs/current/cmds/function.html](https://fishshell.com/docs/current/cmds/function.html).
  #
  #     Why isn't this documented better?
  functionBodiesFromFiles = builtins.mapAttrs (name: otherFunctionAttrs:
  # TODO: write this nicer
  # (like, why not use map?)
    {
      body = builtins.readFile ./${name}.fish;
    } // otherFunctionAttrs
  );
in {
  programs.fish.functions = functionBodiesFromFiles {
    # TODO: fish greeting
    fish_prompt = {};
    fish_user_key_bindings = {};

    back_up_home = {};
  };
}
