{ ... }:
{
  programs.tmux = {
    tmuxinator.enable = true;
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    mouse=true;
  };
}
