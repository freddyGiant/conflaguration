let
in
{ pkgs, ... }: {
  home.packages = with pkgs; [
    curl
    stdenv.cc
  ];
}
