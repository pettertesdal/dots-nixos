{ pkgs, ... }:
{
  imports = [
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    ripgrep # recursively searches directories for a rgex pattern
    jq # A lightweight and flexible command-line JSON processor
    fzf # A command-line fuzzy finder
    brightnessctl
    btop
    dust
    powertop
    zip
    unzip
    dwarf-fortress-packages.dwarf-fortress-full
  ];
}
