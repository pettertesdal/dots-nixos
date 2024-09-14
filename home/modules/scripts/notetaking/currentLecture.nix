{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "current_lecture" ''
        #!/etc/profiles/per-user/tesdap/bin/bash
        cd ~/documents/university/courses/
        CURRENT_COURSE=$( find . -maxdepth 1 -type d -not -name '.*' -printf "%P\n" | rofi -dmenu -no-custom -p "Select domain" )

        ln -sfn $CURRENT_COURSE ../current_course
    '';
  in [
    specialisation
  ];
}
