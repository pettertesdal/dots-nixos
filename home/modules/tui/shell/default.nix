{ pkgs, ... }:
{
  imports = [
    ./starship.nix
    ./aliases.nix
    ./tmux.nix
    ./zellij.nix
  ];
  programs = {

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
    direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
