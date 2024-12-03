{ config, lib, ... }:
let
  inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base06 base08;
in
{
  services.dunst = {
    enable = true;
    settings = {
      theme = {
        # Appearance settings
        frame_color = "#ebdbb2";  # Border color
        background = "#282828";  # Background color
        foreground = "#ebdbb2";  # Text color
        border_radius = 9;       # Rounded corners

        # Behavior settings
        timeout = 5;             # Default timeout in seconds
        ignore_newline = true;   # Handle multiline messages

        # Placement
        geometry = "300x80-20+20";  # Position and size of notifications
      };
    };
  };
}
