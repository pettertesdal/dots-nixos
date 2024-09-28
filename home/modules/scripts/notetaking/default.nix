{ pkgs, ... }:
{
  imports = [
    ./rapport.nix
    ./current_lecture.nix
    ./newlecture.nix
  ];
}
