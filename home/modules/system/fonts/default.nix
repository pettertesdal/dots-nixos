{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerd-fonts.meslo-lg
    pkgs.nerd-fonts.fantasque-sans-mono
    pkgs.nerd-fonts.proggy-clean-tt
  ];
}
