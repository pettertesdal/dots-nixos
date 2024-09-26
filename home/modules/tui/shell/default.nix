{ pkgs, ... }:
{
  imports = [
    ./aliases.nix
    ./tmux.nix
  ];
  programs = {

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;


      oh-my-zsh = {
        enable = true;
        plugins = [ "direnv" ];
        theme = "robbyrussell";
      };
    };
    direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
