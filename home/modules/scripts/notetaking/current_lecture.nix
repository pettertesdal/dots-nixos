{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "current_lecture" ''
        #!/etc/profiles/per-user/tesdap/bin/bash
        cd ~/documents/university/courses/
        CURRENT_COURSE=$( find . -maxdepth 1 -type d -not -name '.*' -printf "%P\n" | rofi -dmenu -no-custom -p "Select domain" )

        cd ..

        ln -sfn courses/$CURRENT_COURSE current_course
        pkill -RTMIN+10 waybar  # Emit the signal (adjust number based on your config)
    '';
  in [
    specialisation
  ];
}
