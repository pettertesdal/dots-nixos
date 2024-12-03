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
    settings = {
      execute_on_song_change = ''$HOME/.dots/home/modules/scripts/musicnotification.sh'';
    };
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
