{ config, inputs, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "~/media/music";
    network = {
      startWhenNeeded = true;
    };
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };
  programs.ncmpcpp = {
    enable = true;
  };
  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     theme = spicePkgs.themes.dribbblish;
     colorScheme = "gruvbox";
   };
}
