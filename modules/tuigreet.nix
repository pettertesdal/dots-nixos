{ config, lib, pkgs, ... }:
let
  command = "${pkgs.swww}/bin/swww init && sleep 1 && ${pkgs.hyprland}/bin/hyprland";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${command}";
      };
    };
  };
}
