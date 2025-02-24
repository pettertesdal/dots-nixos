{ config, lib, pkgs, ... }:
let
  command = "swww init && sleep 1 && Hyprland";
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
