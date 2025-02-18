{ pkgs, ... }:

{
  programs.starship = {
      enable = true;
        settings = builtins.fromTOML ((builtins.readFile ./gruvbox-rainbow.toml)) // {
      };
    };

}

