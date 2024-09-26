{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "sysupdate" ''
      set -e

      # cd to your config dir
      pushd ~/.dots/

      # Early return if no changes were detected
      if git ls-files '*.nix' | xargs git diff --quiet; then
        echo "No changes detected, exiting."
        popd
        exit 0
      fi

      echo "NixOS Rebuilding..."

      # Rebuild, output simplified errors, log tracebacks
      sudo nixos-rebuild switch --flake ~/.dots/ >nixos-switch.log 2>&1 || (cat nixos-switch.log | grep --color error && exit 1)

      # Get current generation metadata
      current=$(nixos-rebuild list-generations | grep current | awk '{print $1, $2, $3}')

      # Commit all changes with the generation metadata
      git commit -am "$current"
      git push

      # Back to where you were
      popd

      # Notify all OK!
      /usr/bin/notify-send "NixOS Rebuilt OK!" --icon=software-update-available

    '';
  in [
    specialisation
  ];
}

