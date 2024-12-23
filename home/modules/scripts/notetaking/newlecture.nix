{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "newlecture" ''
      cd ~/documents/university/
      CREATION_TYPE=$(echo -e "lecture\ncourse\nproject" | rofi -dmenu -no-custom -p "Select option")

      # Creating a new lecture
      if [ "$CREATION_TYPE" == "lecture" ]; then
        cd current_course/chapters/lectures
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
        cd ..
        master_file="Lectures.tex"

        if [ -f "$master_file" ]; then
          # Check if any \input{lec_xx.tex} exists
          if grep -q "/\\input{lec_" "$master_file"; then
            # Find the highest existing \input{lec_XX.tex} and append after it
            sed -i "/\\input{lec_$highest_num.tex}/a \\\\\input\{$new_file\}" "$master_file"
            echo "Added \\input{$new_file} to $master_file after \\input{lec_$highest_num.tex}"
          else
            # No existing \input{lec_xx.tex}, append at the bottom
            echo "\\input{$new_file}" >> "$master_file"
            echo "No \\input{lec_xx.tex} found; appended \\input{$new_file} at the bottom of $master_file"
          fi
        else
          echo "Master file $master_file not found."
        fi

      elif [ "$CREATION_TYPE" == "course" ]; then
        # Use rofi to prompt the user for a course name
        course_name=$(rofi -dmenu -p "Enter course name:")

        # Create the course directory
        course_dir="courses/$course_name"
        mkdir -p "$course_dir"
        echo "Created course directory: $course_dir"
        
        # Change into the course directory
        cd "$course_dir"
        
        # Copy the master.tex file from the template folder
        cp -r ../../../.templates/courses/* .
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

