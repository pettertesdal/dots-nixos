{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "gruvbox-dark";
      default_shell = "${pkgs.zsh}/bin/zsh";
      mouse_mode = true;
    };
  };
}

