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
                 --color background=282828,foreground=ebdbb2,primary=d79921,secondary=b16286,alert=cc241d,selection=458588
        '';
      };
    };
  };
}
