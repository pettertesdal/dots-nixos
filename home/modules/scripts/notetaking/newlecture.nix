{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "newlecture" ''
      cd ~/documents/university/
      CREATION_TYPE=$(echo -e "lecture\ncourse\nproject" | rofi -dmenu -no-custom -p "Select option")

      # Creating a new lecture
      if [ "$CREATION_TYPE" == "lecture" ]; then
        cd current_course
        highest_num=$(ls lec_*.tex 2>/dev/null | grep -oP 'lec_\K\d+(?=\.tex)' | sort -n | tail -1)

        # If no files were found, set the number to 0, else increment the highest found number
        if [ -z "$highest_num" ]; then
          next_num=1
        else
          next_num=$((highest_num + 1))
        fi

        # Create a new file with the next number
        new_file=$(printf "lec_%02d.tex" "$next_num")
        full_path=$(realpath "$new_file")
        touch "$new_file"
        echo "Created new file at: $full_path"

        # Add \lecture{} command at the top of the new file
        current_date=$(date +"%d-%m-%Y")
        lecture_command="\\lecture{$next_num}{$current_date}{title}{professor}"

        # Insert the \lecture command at the beginning of the new file
        echo -e "$lecture_command\n" | cat - "$new_file" > temp && mv temp "$new_file"



        # Add the new file to master.tex before \end{document}
        master_file="master.tex"
        if [ -f "$master_file" ]; then
          # Find the highest existing \input{lec_XX.tex} and append after it
          sed -i "/\\input{lec_$highest_num.tex}/a \\\\\input\{$new_file\}" "$master_file"
          echo "Added \\input{$new_file} to $master_file after \\input{lec_$highest_num.tex}"
        else
          echo "master.tex not found!"
        fi
      elif [ "$CREATION_TYPE" == "course" ]; then
        # Use rofi to prompt the user for a course name
        course_name=$(rofi -dmenu -p "Enter course name:")
        AFFILIATION=$(echo -e "none\nhvl\nuib\nhvl-uib\nfmc" | rofi -dmenu -no-custom -p "Select affiliation")

        # Create the course directory
        course_dir="courses/$course_name"
        mkdir -p "$course_dir"
        echo "Created course directory: $course_dir"
        
        # Change into the course directory
        cd "$course_dir"
        
        if [ "$AFFILIATION" == "hvl-uib" ]; then
          cp ../../.templates/courses/hvl.png ./logo1.png
          cp ../../.templates/courses/uib.png ./logo2.png
        else
          echo "$AFFILIATION"
          echo "no affiliation"
        fi

        # Create a symlink to ../../.templates/custom.sty
        ln -s ../../.templates/custom.sty ./
        echo "Created symlink to custom.sty"

        # Copy the master.tex file from the template folder
        cp ../../.templates/courses/master.tex .
        echo "Copied master.tex from template"
      else
        cd courses
        
      echo "Not implemented"
      fi
      '';
  in [
    specialisation
  ];
}

