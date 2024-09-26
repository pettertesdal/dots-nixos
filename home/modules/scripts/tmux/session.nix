{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "tmux_attach_current_sessions" ''

      function tmux_sessions() {
        tmuxinator list | sed -n '2p' | tr -s ' ' | tr ' ' '\n'
      }

      TMUX_SESSION=$( (echo new; tmux_sessions) | rofi -dmenu -p "Select tmux session")

      tmuxinator start ''${TMUX_SESSION}
    '';
  in [
    specialisation
  ];
}
