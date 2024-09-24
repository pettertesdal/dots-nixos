{ config, ... }:
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
}
