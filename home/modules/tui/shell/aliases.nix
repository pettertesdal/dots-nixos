{
  home.shellAliases = {
    systest = "sudo nixos-rebuild test --flake ~/.dots/";
    current = "cd ~/documents/university/current_course/";
    zms = "zellij attach $(zellij ls -s | fzf)";
  };
}
