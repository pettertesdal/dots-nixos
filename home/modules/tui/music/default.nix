{ ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = ~/media/music/;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  }
}
