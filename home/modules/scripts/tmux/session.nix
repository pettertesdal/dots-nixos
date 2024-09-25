{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "tmux_attach_current_sessions" ''
      function tmux_sessions()
      {
          tmuxinator list | sed -n '2p' | tr -s ' ' | tr ' ' '\n'
      }

      TMUX_SESSION=$( (echo new; tmux_sessions) | rofi -dmenu -p "Select tmux session")

      if [[ x"new" = x"''${TMUX_SESSION}" ]]; then
          rofi-sensible-terminal -e tmux new-session &
      elif [[ -z "''${TMUX_SESSION}" ]]; then
          echo "Cancel"
      else
          rofi-sensible-terminal -e tmuxinator start "''${TMUX_SESSION}" &
      fi

    '';
  in [
    specialisation
  ];
}
