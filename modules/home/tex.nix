# FIXME: this module probably shouldn't even exist
# TODO: finish, or switch to typst
# really basic
# (currently) doesn't make sense without neovim
{ config, lib, pkgs, ... }: lib.mkIf config.programs.neovim.enable {
  programs.texlive.enable = true;

  # this is good, though
  # although it should probabkly be the package field for the hm option
  home.packages = [
    (pkgs.texliveFull.withPackages (ps: [ ps.latexmk ]))
  ];

  programs.neovim.plugins = [{
    plugin = pkgs.vimPlugins.vimtex;
    type = "lua";
    # config = /* lua */ ''
    # '';
  }];

  programs.zathura.enable = true;
}
