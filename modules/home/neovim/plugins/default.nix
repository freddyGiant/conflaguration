let
  pluginConfigsFromFiles = map (name:
    {
      plugin = pkgs.vimPlugins.${name};
      type = "lua";
      config = builtins.readFile ./${name};
    }
  );
  mkPlugins = ps: let
    ps' = foldl'
      (pAcc: { p, fromFile ? false, dependsOn ? [] }: {
        pAcc = pAcc ++ [ 
      })
      { p = []; pRest = []; }
      ps;
  in 
    ps'.p ++ ps'.pRest;
in { pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-repeat
  ] ++ pluginConfigsFromFiles [
    "gruvbox-material-nvim"
    "blink-cmp"
    "leap-nvim"
  ];

  programs.neovim.plugins = mkPlugins [
    { p: gruvbox-material-nvim; fromFile = true; }
    { p: blink-cmp; fromFile = true; }
    { p: leap-nvim; fromFile = true; dependsOn = [ vim-repeat ]; }
  ];
}
