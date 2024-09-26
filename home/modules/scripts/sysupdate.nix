{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "sysupdate" ''
      set -e

      # cd to your config dir
      pushd ~/.dots/ || { notify-send "Failed to enter config directory!" --icon=dialog-error; exit 1; }

      echo "NixOS Rebuilding..."

      # Try to rebuild, and handle errors
      if ! sudo nixos-rebuild switch --flake "$HOME/.dots/" >nixos-switch.log 2>&1; then
          cat nixos-switch.log | grep --color error
          notify-send "NixOS Rebuild Failed! 󰅚 " --icon=dialog-error
          exit 1
      fi

      # If rebuild is successful, proceed
      git add -A
      git commit -m "sysupdate" || { notify-send "Git Commit Failed!" --icon=dialog-error; exit 1; }
      git push || { notify-send "Git Push Failed!" --icon=dialog-error; exit 1; }

      # Back to where you were
      popd || { notify-send "Failed to return to previous directory!" --icon=dialog-error; exit 1; }

      # Notify all OK!
      notify-send "NixOS Rebuilt OK! 󰅠 " --icon=software-update-available

    '';
  in [
    specialisation
  ];
}

