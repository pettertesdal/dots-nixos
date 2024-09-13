{ pkgs, ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "lecture" ''
# Change to the vaults directory
cd ~/vaults || { echo "Could not enter directory ~/vaults"; exit 1; }

# List directories, excluding 'templates'
echo "Available directories (excluding 'templates'):"
select dir in $(find . -mindepth 1 -maxdepth 1 -type d ! -name 'templates' -exec basename {} \;); do
    if [ -n "$dir" ]; then
        echo "You selected: $dir"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Ask for the new directory name for lecture notes
read -p "Enter the name of the new directory for lecture notes: " new_dir

# Create the new directory inside the chosen vault directory
mkdir -p "$dir/$new_dir"

# Copy the template contents into the new directory
cp -r ~/vaults/templates/lectures/* "$dir/$new_dir"

echo "Lecture notes template copied to $dir/$new_dir"
cd ~/vaults/$dir/$new_dir
nvim main.tex

    '';
  in [
    specialisation
  ];
}
