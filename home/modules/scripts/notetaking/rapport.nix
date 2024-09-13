{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "rapport" ''
    #!/bin/bash

# Navigate to the ~/vaults directory
cd ~/vaults || { echo "Failed to enter ~/vaults directory"; exit 1; }

# List directories except the hidden .templates one
echo "Available directories in ~/vaults:"
dirs=($(find . -maxdepth 1 -type d -not -name '.*' -printf "%P\n"))
PS3="Choose a directory (enter the number): "
select chosen_dir in "''${dirs[@]}"; do
    if [[ -n "$chosen_dir" ]]; then
        break
    else
        echo "Invalid selection. Please choose a valid directory."
    fi
done

# Save the path of the chosen directory
chosen_path="$chosen_dir"
echo "You chose: $chosen_path"

# Navigate to the .templates folder and list its directories
cd ~/vaults/.templates || { echo "Failed to enter ~/.templates directory"; exit 1; }

echo "Available templates in .templates:"
templates=($(find . -maxdepth 1 -type d -not -name '.*' -printf "%P\n"))
PS3="Choose a template (enter the number): "
select template_dir in "''${templates[@]}"; do
    if [[ -n "$template_dir" ]]; then
        break
    else
        echo "Invalid selection. Please choose a valid template."
    fi
done

# Check if the chosen template directory contains a 'default' directory
template_path="$HOME/vaults/.templates/$template_dir"
default_path="$template_path/default"

if [ -d "$default_path" ]; then
    subdirs=($(find "$template_path" -maxdepth 1 -type d -not -name '.*' -not -path "$template_path" -printf "%P\n"))

    # Automatically choose the directory if it matches the chosen directory name from ~/vaults
    match_found=false
    for subdir in "''${subdirs[@]}"; do
        if [[ "$subdir" == "$chosen_path" ]]; then
            final_choice="$subdir"
            match_found=true
            echo "Automatically choosing the subdirectory $subdir because it matches the chosen directory from ~/vaults."
            break
        fi
    done

    if [[ "$match_found" == false ]]; then
        # If no match found, either choose default or ask the user
        if [[ ''${#subdirs[@]} -eq 1 && ''${subdirs[0]} == "default" ]]; then
            final_choice="default"
            echo "Only 'default' directory found. Automatically choosing 'default'."
        else
            echo "Multiple subdirectories found in the template:"
            PS3="Choose a directory (or 'default'): "
            select final_choice in "''${subdirs[@]}"; do
                if [[ -n "$final_choice" ]]; then
                    break
                else
                    echo "Invalid selection. Please choose a valid subdirectory."
                fi
            done
        fi
    fi
else
    echo "No 'default' directory found in the chosen template."
    exit 1
fi


# Check if a folder with the template name exists in the chosen directory
final_dest_dir=~/vaults/"$chosen_path"/"$template_dir"
if [ ! -d "$final_dest_dir" ]; then
    echo "Creating folder $template_dir in $chosen_path"
    mkdir -p "$final_dest_dir"
else
    echo "Folder $template_dir already exists in $chosen_path"
fi

# Function to check if the name already exists in the destination directory
check_name_existence() {
    local dest_path=$1
    local name=$2
    if [ -d "$dest_path/$name" ]; then
        return 0  # Name exists
    else
        return 1  # Name does not exist
    fi
}

# Ask the user for a name for the new directory, and check if it already exists
while true; do
    read -rp "Enter a name for the new directory: " new_dir_name
    final_dest_dir=~/vaults/"$chosen_path"/"$template_dir"
    if check_name_existence "$final_dest_dir" "$new_dir_name"; then
        echo "A folder with the name '$new_dir_name' already exists in $final_dest_dir. Please choose another name."
    else
        break
    fi
done

# Copy the template content into the chosen folder inside the chosen directory
new_dir_path="$final_dest_dir/$new_dir_name"
mkdir -p "$new_dir_path"
cp -r "$template_path/$final_choice"/* "$new_dir_path"

echo "Template copied to $new_dir_path. Script finished!"

cd $new_dir_path

    '';
  in [
    specialisation
  ];
}
