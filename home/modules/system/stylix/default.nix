{ config, lib, pkgs, ... }:
let
  themePath = "~/.dots/home/themes/gruvbox-dark";
in
{
  stylix = {
    enable = true;
    polarity = "dark";
    image = themePath + "/background.png";
    base16Scheme = "${themePath}/colors.yaml";

    fonts = {
      monospace = {
        name = "ProggyClean CE Nerd Font";
      };
      serif = {
        name = "ProggyClean CE Nerd Font";
      };
      sansSerif = {
        name = "ProggyClean CE Nerd Font";
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
