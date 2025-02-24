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
                 --theme 'text=white;time=yellow;container=grey;border=yellow;title=white;greet=white;prompt=white;input=white;action=white;button=white'
        '';
      };
    };
  };
}
