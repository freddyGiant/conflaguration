{ config, lib, ... }: {
  # what else is setting this?? oh well
  home.homeDirectory = lib.mkForce /home/${config.home.username};

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;

    desktop      =    config.home.homeDirectory;
    download     = /${config.home.homeDirectory}/dwn;
    documents    = /${config.home.homeDirectory}/med/doc;
    music        = /${config.home.homeDirectory}/med/mus;
    pictures     = /${config.home.homeDirectory}/med/pic;
    videos       = /${config.home.homeDirectory}/med/vid;
    publicShare  = /${config.home.homeDirectory}/public;
    templates    = /${config.home.homeDirectory}/templates;
  };
  # old value
  # TODO: would disabling this break stuff?
  xdg.userDirs.setSessionVariables = true;
}
