{ ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_shell = "fish";
    }
  };
}
