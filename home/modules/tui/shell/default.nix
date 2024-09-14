{ pkgs, ... }:
{
  imports = [
    ./aliases.nix
    ./tmux.nix
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.dots/";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [  ];
      theme = "robbyrussell";
    };
  };
}
