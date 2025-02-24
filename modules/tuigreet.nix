{ config, lib, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland \
                 --time \
                 --asterisks \
                 --user-menu \
                 --remember \
                 --theme 'text=white;time=yellow;container=black;border=blue;title=yellow;greet=green;prompt=bright_red;input=magenta;action=cyan;button=bright_yellow'
        '';
      };
    };
  };
}
