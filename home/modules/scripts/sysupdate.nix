{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "sysupdate" ''
      set -e

      # cd to your config dir
      pushd ~/.dots/

      echo "NixOS Rebuilding..."

      sudo nixos-rebuild switch --flake $HOME/.dots/ >nixos-switch.log 2>&1 || (cat nixos-switch.log | grep --color error && exit 1)

      git add -A
      git commit -m "sysupdate"
      git push

      # Back to where you were
      popd

      # Notify all OK!
      notify-send "NixOS Rebuilt OK! 󰅠 " --icon=software-update-available

    '';
  in [
    specialisation
  ];
}

