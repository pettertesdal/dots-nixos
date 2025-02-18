{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_shell = "${pkgs.zsh}/bin/zsh";
    };
  };
}

