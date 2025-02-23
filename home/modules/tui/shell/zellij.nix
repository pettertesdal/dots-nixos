{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;

    settings = {
      theme = "gruvbox-dark";
      default_shell = "${pkgs.zsh}/bin/zsh";
      auto_attach = false; # Ensures it doesn't automatically attach
      mouse_mode = true;
    };
  };
}

