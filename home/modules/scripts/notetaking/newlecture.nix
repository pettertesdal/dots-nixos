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

        # NEW #######
        lecture_template_beg="\begin{lecture}{professor}{Lecture $next_num}{$current_date}{0}"
        lecture_template_end="\end{lecture}"

        # Insert the lecture template into the new file
        echo "$lecture_template_beg" >> "$new_file"
        echo "" >> "$new_file"
        echo "$lecture_template_end" >> "$new_file"

        # NEW #######

        # Add the new file to master.tex before \end{document}
        cd ..
        master_file="Lectures.tex"

        if [ -f "$master_file" ]; then
          # Check if any \input{lec_xx.tex} exists
          if grep -q "/\\input{lec_" "$master_file"; then
            # Find the highest existing \input{lec_XX.tex} and append after it
            sed -i "/\\input{chapters/lectures/lec_$highest_num.tex}/a \\\\\input\{$new_file\}" "$master_file"
            echo "Added \\input{$new_file} to $master_file after \\input{lec_$highest_num.tex}"
          else
            # No existing \input{lec_xx.tex}, append at the bottom
            echo "\\input{chapters/lectures/$new_file}" >> "$master_file"
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
        cd "$course_dir" || exit
        
        # Define the source template and the folder to be symlinked
        template_dir="../../../.templates/courses"
        symlink_target="preamble" # Replace with the actual folder name you want as a symlink

        # Copy everything except the specific folder
        rsync -av --exclude="$symlink_target" "$template_dir/" .
        
        # Create the symlink for the excluded folder
        ln -s "$template_dir/$symlink_target" "$symlink_target"
        echo "Copied template except '$symlink_target' and created a symlink for it."
      else
        cd courses || exit
        echo "Not implemented"
      fi
      '';
  in [
    specialisation
  ];
}

