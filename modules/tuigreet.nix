{ config, lib, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland \
                 --time \
                 --remember \
                 --greeting "Welcome Petter"
        '';
      };
    };
  };
}
