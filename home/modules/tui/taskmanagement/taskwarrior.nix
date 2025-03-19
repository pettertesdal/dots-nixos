{ pkgs, ... }:
{
  programs.taskwarrior = {
    enable = true;
    dataLocation = "$HOME/documents/.tasks/"
  };
}
