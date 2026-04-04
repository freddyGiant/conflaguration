{ config, ... }: {
  home.homeDirectory = /home/${config.home.username};

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
}
