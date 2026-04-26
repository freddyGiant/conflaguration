{
  pluginConfigFromFile = pkgs: name: {
    plugin = pkgs.vimPlugins.${name};
    type = "lua";
    config = builtins.readFile ./${name};
  };
}
