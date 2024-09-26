{ config, lib, pkgs, ... }:
let
  themePath = ./../../../themes/gruvbox-dark;
in
{
  stylix = {
    enable = true;
    polarity = "dark";
    image = themePath + "/background.png";
    base16Scheme = themePath + "/colors.yaml";

    fonts = {
      monospace = {
        name = "FantasqueSansM mono";
        package = pkgs.fantasque-sans-mono;
      };
      serif = {
        name = "FantasqueSansM mono";
        package = pkgs.fantasque-sans-mono;
      };
      sansSerif = {
        name = "FantasqueSansM mono";
        package = pkgs.fantasque-sans-mono;
      };
      sizes = {
        terminal = 18;
        applications = 12;
        popups = 12;
        desktop = 12;
      };
    };
  };
}
